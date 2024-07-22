const express = require('express');
const Orderrouter = express.Router();
const Order = require('../models/order');
const Menu = require('../models/menu'); 
const User = require('../models/User')
// Orderrouter.get('/orders', async (req, res) => {
//   const userId = req.headers['userid'];
//   console.log(userId)
//   try {
//     const orders = await Order.find({ user: userId });

//     const totalOrdersCount = orders.length;
//     const totalExpenditure = orders.reduce((total, order) => total + order.totalPrice, 0);

//     res.json({
//       orders,
//       totalOrdersCount,
//       totalExpenditure
//     });

//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ error: 'Server error' });
//   }
// });


Orderrouter.get('/orders', async (req, res) => {
  const userId = req.headers['userid'];
  console.log(userId);



  try {
    const user = await User.findOne({ _id: userId });
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    const balance = user.balance;
    const orders = await Order.find({ user: userId }).populate('items.foodItem', 'name price category');

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce((total, order) => total + order.totalPrice, 0);

  
    const transformedOrders = orders.map(order => {
      const orderObj = order.toObject();
      const orderDate = new Date(orderObj.orderTime);
      const format = orderDate.toLocaleDateString('en-GB', {
        day: '2-digit',
        month: '2-digit',
        year: '2-digit'
      });
  
      return {
        ...orderObj,
        formatDate: format,
        balance,
        items: orderObj.items.map(item => ({
          ...item,
          foodItemName: item.foodItem ? item.foodItem.name : 'Unknown Item',
          foodItemCategory: item.foodItem ? item.foodItem.category : 'Unknown Category',
          foodItemId: item.foodItem ? item.foodItem._id : null,
          foodItem: undefined  
        }))
      };
    });

    res.json({
      orders: transformedOrders,
      totalOrdersCount,
      totalExpenditure
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});





Orderrouter.get('/api/recentOrders', async (req, res) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const orders = await Order.find({
      orderTime: { $gte: today, $lt: tomorrow }
    }).populate('items.foodItem', 'name price category');

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce((total, order) => total + order.totalPrice, 0);

    const transformedOrders = await Promise.all(orders.map(async order => {
      const orderObj = order.toObject();
      const orderDate = new Date(orderObj.orderTime);
      const format = orderDate.toLocaleDateString('en-GB', {
        day: '2-digit',
        month: '2-digit',
        year: '2-digit'
      });

      const user = await User.findById(order.user);

      return {
        ...orderObj,
        formatDate: format,
        user: user ? user.name : null,
        items: orderObj.items.map(item => ({
          ...item,
          foodItemName: item.foodItem ? item.foodItem.name : 'Unknown Item',
          foodItemCategory: item.foodItem ? item.foodItem.category : 'Unknown Category',
          foodItemId: item.foodItem ? item.foodItem._id : null,
          foodItem: undefined
        }))
      };
    }));

    res.json({
      orders: transformedOrders,
      totalOrdersCount,
      totalExpenditure
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Server Error" });
  }

});


//update order
Orderrouter.put('/api/orders/:orderId', async (req, res) => {
  try {
    const { orderId } = req.params;
    const { action, updates } = req.body;
    const order = await Order.findById(orderId).populate('user');

    if (!order) {
      return res.status(404).json({ error: 'Order not found' });
    }

    if (order.status !== 'pending') {
      return res.status(400).json({ error: 'Only pending orders can be edited or confirmed' });
    }

    if (action === 'edit') {
      if (updates.items) {
        order.items = updates.items;
        
        order.totalPrice = order.items.reduce((total, item) => total + (item.price * item.quantity), 0);
      }

      ['user', 'orderTime', 'status'].forEach(key => {
        if (updates[key] && key !== '_id') {
          order[key] = updates[key];
        }
      });

      await order.save();
      res.json({ message: 'Order updated successfully', order });
    } else if (action === 'confirm') {
      const user = order.user;
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      user.balance += order.totalPrice;
      await user.save();
      order.status = 'confirmed';
      await order.save();
      res.json({ message: 'Order confirmed successfully', order });
    } else {
      res.status(400).json({ error: 'Invalid action. Use "edit" or "confirm".' });
    }
  } catch (err) {
    console.error('Error updating order:', err);
    res.status(500).json({ error: 'Server error' });
  }
});



//user orders
Orderrouter.get('/api/:userId/orders', async (req, res) => {

  try {
    const userId= req.params.userId;
    const user = await User.findOne({userId});
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    const orders = await Order.find({ user: userId }).populate('items.foodItem', 'name price category');

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce((total, order) => total + order.totalPrice, 0);

  
    const transformedOrders = orders.map(order => {
      const orderObj = order.toObject();
      const orderDate = new Date(orderObj.orderTime);
      const format = orderDate.toLocaleDateString('en-GB', {
        day: '2-digit',
        month: '2-digit',
        year: '2-digit'
      });
  
      return {
        ...orderObj,
        formatDate: format,
        items: orderObj.items.map(item => ({
          ...item,
          foodItemName: item.foodItem ? item.foodItem.name : 'Unknown Item',
          foodItemCategory: item.foodItem ? item.foodItem.category : 'Unknown Category',
          foodItemId: item.foodItem ? item.foodItem._id : null,
          foodItem: undefined  
        }))
      };
    });

    res.json({
      orders: transformedOrders,
      totalOrdersCount,
      totalExpenditure
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});







Orderrouter.post('/api/Addorders', async (req, res) => {
  try {
    const { items } = req.body;
    const userId = req.headers['userid'];


    if (!items || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: 'Invalid order items' });
    }

    let totalPrice = 0;
    const orderItems = [];

    for (let item of items) {
      const foodItem = await Menu.findById(item.menu);
      if (!foodItem) {
        return res.status(400).json({ error: `Food item not found: ${item.menu}` });
      }

      const itemTotal = foodItem.price * item.quantity;
      totalPrice += itemTotal;

      orderItems.push({
        foodItem: item.menu,
        quantity: item.quantity,
        price: foodItem.price
      });
    }

    const newOrder = new Order({
      user: userId,
      items: orderItems,
      totalPrice,
      orderTime: new Date()
    });

    await newOrder.save();

    res.status(201).json(newOrder);
  } catch (err) {
    console.error('Error adding new order:', err);
    res.status(500).json({ error: 'Server error' });
  }
});





Orderrouter.get('/api/daily-order-count', async (req, res) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const dailyOrders = await Order.find({
      createdAt: {
        $gte: today,
        $lt: tomorrow
      }
    });

    const orderCount = dailyOrders.length;

    const totalRevenue = dailyOrders.reduce((sum, order) => sum + (order.totalPrice || 0), 0);

  

    res.json({
      date: today.toISOString().split('T')[0],
      orderCount,
      totalRevenue,
    });

  } catch (err) {
    console.error('Error fetching daily order count:', err);
    res.status(500).json({ error: 'Server error' });
  }
});





module.exports = Orderrouter;



