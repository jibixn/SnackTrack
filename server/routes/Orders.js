const express = require('express');
const Orderrouter = express.Router();
const Order = require('../models/order');
const Menu = require('../models/menu'); 

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
    const orders = await Order.find({ user: userId }).populate('items.foodItem', 'name price category');

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce((total, order) => total + order.totalPrice, 0);

    const orderDate = new Date(orderObj.orderTime);
    const format = orderDate.toLocaleDateString('en-GB', {
      day: '2-digit',
      month: '2-digit',
      year: '2-digit'
    });

    const transformedOrders = orders.map(order => {
      const orderObj = order.toObject();
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
    // const userId = req.user._id;
    const userId='6607b67f4944e4489fb90641'

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




module.exports = Orderrouter;



