const express = require("express");
const mongoose = require("mongoose");
const Orderrouter = express.Router();
const Order = require("../models/order");
const Menu = require("../models/menu");
const User = require("../models/User");
require('dotenv').config();



const admin = require('firebase-admin');
const serviceAccount = JSON.parse(process.env.FIREBASE_ACCOUNT);


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});


// admin.app().options.credential.getAccessToken()
//   .then(() => console.log('Firebase Admin SDK initialized successfully'))
//   .catch((error) => console.error('Failed to initialize Firebase Admin SDK:', error));

Orderrouter.get("/orders", async (req, res) => {
  const userId = req.headers["userid"];

  try {
    const user = await User.findOne({ _id: userId });
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    const balance = user.balance;

    const now = new Date();
    const currentYear = now.getFullYear();
    const currentMonth = now.getMonth(); 

    const startDate = new Date(Date.UTC(currentYear, currentMonth, 1));
    const endDate = new Date(Date.UTC(currentYear, currentMonth + 1, 0, 23, 59, 59, 999));

    const orders = await Order.find({
      user: userId,
      orderTime: { $gte: startDate, $lte: endDate }
    }).populate("items.foodItem", "name price category");

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce(
      (total, order) => total + order.totalPrice,
      0
    );

    const transformedOrders = orders.map((order) => {
      const orderObj = order.toObject();
      const orderDate = new Date(orderObj.orderTime);
      const format = orderDate.toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "2-digit",
        year: "2-digit",
      });
      return {
        ...orderObj,
        formatDate: format,
        balance,
        items: orderObj.items.map((item) => ({
          ...item,
          foodItemName: item.foodItem ? item.foodItem.name : "Unknown Item",
          foodItemCategory: item.foodItem
            ? item.foodItem.category
            : "Unknown Category",
          foodItemId: item.foodItem ? item.foodItem._id : null,
          foodItem: undefined,
        })),
      };
    });

    res.json({
      orders: transformedOrders,
      totalOrdersCount,
      totalExpenditure,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});





//clear
Orderrouter.delete("/api/clear-all-orders", async (req, res) => {
  try {
    const result = await Order.deleteMany({});

    if (result.deletedCount === 0) {
      return res.status(404).json({ message: "No orders found to delete" });
    }

    res.status(200).json({ 
      message: "All orders have been successfully deleted",
      deletedCount: result.deletedCount
    });
  } catch (error) {
    console.error("Error clearing orders:", error);
    res.status(500).json({ error: "Server error", details: error.message });
  }
});

Orderrouter.get("/api/recentOrders", async (req, res) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const orders = await Order.find({
      orderTime: { $gte: today, $lt: tomorrow },
    }).populate("items.foodItem", "name price category");

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce(
      (total, order) => total + order.totalPrice,
      0
    );

    const transformedOrders = await Promise.all(
      orders.map(async (order) => {
        const orderObj = order.toObject();
        const orderDate = new Date(orderObj.orderTime);
        const format = orderDate.toLocaleDateString("en-GB", {
          day: "2-digit",
          month: "2-digit",
          year: "2-digit",
        });

        const user = await User.findById(order.user);
        return {
          ...orderObj,
          formatDate: format,
          user: user ? user.name : null,
          items: orderObj.items.map((item) => ({
            ...item,
            foodItemName: item.foodItem ? item.foodItem.name : "Unknown Item",
            foodItemCategory: item.foodItem
              ? item.foodItem.category
              : "Unknown Category",
            foodItemId: item.foodItem ? item.foodItem._id : null,
            foodItem: undefined,
          })),
        };
      })
    );

    res.json({
      orders: transformedOrders,
      totalOrdersCount,
      totalExpenditure,
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Server Error" });
  }
});


//confirm-order
Orderrouter.put("/api/confirm-order/:orderId", async (req, res) => {
  try {
    const { orderId } = req.params;
    const order = await Order.findById(orderId).populate("user", "-password");
    const user = order.user;

    if(order.status==="edited"){
      order.status="tchrConfirmed";
      await order.save();
      res.status(200).json({ message: "Order confirmed by faculty successfully" });


    }else{
      res.status(200).json({ message: "Only edited Orders can be confirmed" });

    }
    
  } catch (err) {
    console.error("Error updating order:", err);
    res.status(500).json({ error: "Server error" });
  }

});


// update order
Orderrouter.put("/api/orders/:orderId", async (req, res) => {
  try {
    const { orderId } = req.params;
    const { action, items, isPaying, amt } = req.body;

    const order = await Order.findById(orderId).populate("user", "-password");
    if (!order) {
      return res.status(404).json({ error: "Order not found" });
    }
    if (!order.user) {
      return res.status(404).json({ error: "User associated with order not found" });
    }

    const user = order.user;

    if (!["pending", "edited", "tchrConfirmed"].includes(order.status)) {
      return res.status(400).json({ error: "Only pending, edited, or teacher-confirmed orders can be modified" });
    }

    if (action === "edit") {
      if (!items || !Array.isArray(items)) {
        return res.status(400).json({ error: "Invalid items data" });
      }

      const updatedItems = [];
      let totalPrice = 0;

      for (let item of items) {
        const foodItem = await Menu.findById(item.foodItemId);
        if (!foodItem) {
          return res.status(400).json({ error: `Food item not found: ${item.foodItemId}` });
        }

        const itemPrice = item.price || foodItem.price;
        const itemTotal = itemPrice * item.quantity;
        totalPrice += itemTotal;

        updatedItems.push({
          foodItem: item.foodItemId,
          quantity: item.quantity,
          price: itemPrice,
          foodItemName: foodItem.name,
          foodItemCategory: foodItem.category,
        });
      }

      order.status = "edited";
      order.items = updatedItems;
      order.totalPrice = totalPrice;
      await order.save();

      await sendNotification(user.fcmtoken, "Order Edited", "Your order has been edited. Please review the changes.");

    } else if (action === "confirm") {
      if (order.status === "edited" || order.status === "tchrConfirmed") {
        order.status = "confirmed";
        await order.save();
      } else {
        return res.status(400).json({ error: "Order must be in 'edited' or 'tchrConfirmed' status to confirm" });
      }

    } else {
      return res.status(400).json({ error: 'Invalid action. Use "edit" or "confirm".' });
    }

    if (isPaying) {
      if (typeof amt !== 'number' || isNaN(amt)) {
        return res.status(400).json({ error: "Invalid payment amount" });
      }

      if (amt === order.totalPrice) {
        order.status = "Paid";
      } else if (amt < order.totalPrice) {
        const amountPending = order.totalPrice - amt;
        user.balance += amountPending;
        order.status = "PartiallyPaid";
      } else {
        const excess = amt - order.totalPrice;
        user.balance += excess;
        order.status = "Paid";
      }
    } else {
      user.balance += order.totalPrice;
      order.status = "Unpaid";
    }

    await user.save();
    await order.save();

    if (action !== "edit") {
      const notificationBody = isPaying
        ? `Your order has been confirmed. Payment of Rs.${amt} has been processed.`
        : "Your order has been confirmed.";
      await sendNotification(user.fcmtoken, "Order Confirmed ✅", notificationBody);
    }

    res.json({
      message: `Order ${action === "edit" ? "updated" : "confirmed"} successfully${isPaying ? " and payment processed" : ""}`,
      order,
    });

  } catch (err) {
    console.error("Error updating order:", err);
    res.status(500).json({ error: "Server error: " + err.message });
  }
});




async function sendNotification(token, title, body) {
  const message = {
    notification: { title, body },
    token,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
  } catch (error) {
    console.error("Error sending message:", error);
  }
}




//payment
Orderrouter.put("/api/:userId/Payment", async (req, res) => {
  try {
    const { amount } = req.body;
    const userId = req.params.userId;


  const user = await User.findOne({ _id: userId });
  
  if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    user.balance = user.balance - amount;
    await user.save();
    return res.status(200).json({ message: "Payment successful", newBalance: user.balance });

  } catch (e) {
    res.status(500).json({ message: "ServerError" + e });
  }
});




//user orders
Orderrouter.get("/api/:userId/orders", async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findOne({ _id: userId });
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    const orders = await Order.find({ user: userId }).populate(
      "items.foodItem",
      "name price category"
    );

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce(
      (total, order) => total + order.totalPrice,
      0
    );
    const balance = user.balance;

    const currentDate = new Date();
    const currentMonth = currentDate.getMonth();
    const currentYear = currentDate.getFullYear();

    const monthlyOrders = orders.filter((order) => {
      const orderDate = new Date(order.orderTime);
      return (
        orderDate.getMonth() === currentMonth &&
        orderDate.getFullYear() === currentYear
      );
    });

    const monthlyOrderCount = monthlyOrders.length;
    const monthlyExpenditure = monthlyOrders.reduce(
      (total, order) => total + order.totalPrice,
      0
    );

    const transformedOrders = orders.map((order) => {
      const orderObj = order.toObject();
      const orderDate = new Date(orderObj.orderTime);
      const format = orderDate.toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "2-digit",
        year: "2-digit",
      });

      return {
        ...orderObj,
        formatDate: format,
        items: orderObj.items.map((item) => ({
          ...item,
          foodItemName: item.foodItem ? item.foodItem.name : "Unknown Item",
          foodItemCategory: item.foodItem
            ? item.foodItem.category
            : "Unknown Category",
          foodItemId: item.foodItem ? item.foodItem._id : null,
          foodItem: undefined,
        })),
      };
    });

    res.json({
      orders: transformedOrders,
      totalOrdersCount,
      totalExpenditure,
      monthlyOrderCount,
      monthlyExpenditure,
      balance,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});






Orderrouter.post("/api/Addorders", async (req, res) => {
  try {
    const { items } = req.body;
    const userId = req.headers["userid"];

    if (!items || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: "Invalid order items" });
    }

    let totalPrice = 0;
    const orderItems = [];

    for (let item of items) {
      const foodItem = await Menu.findById(item.menu);
      if (!foodItem) {
        return res
          .status(400)
          .json({ error: `Food item not found: ${item.menu}` });
      }

      const itemTotal = foodItem.price * item.quantity;
      totalPrice += itemTotal;

      orderItems.push({
        foodItem: item.menu,
        quantity: item.quantity,
        price: foodItem.price,
      });
    }

    const newOrder = new Order({
      user: userId,
      items: orderItems,
      totalPrice,
      orderTime: new Date(),
    });

    await newOrder.save();

    res.status(201).json(newOrder);
  } catch (err) {
    console.error("Error adding new order:", err);
    res.status(500).json({ error: "Server error" });
  }
});

Orderrouter.get("/api/daily-order-count", async (req, res) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const dailyOrders = await Order.find({
      createdAt: {
        $gte: today,
        $lt: tomorrow,
      },
    });

    const orderCount = dailyOrders.length;

    const totalRevenue = dailyOrders.reduce(
      (sum, order) => sum + (order.totalPrice || 0),
      0
    );

    res.json({
      date: today.toISOString().split("T")[0],
      orderCount,
      totalRevenue,
    });
  } catch (err) {
    console.error("Error fetching daily order count:", err);
    res.status(500).json({ error: "Server error" });
  }
});

//pending orders
Orderrouter.get("/api/pending", async (req, res) => {
  try {
    const pending = await Order.find({ status: "pending" });
    res.status(200).json({ pending: pending });
  } catch (e) {
    res.status(500).json({ error: "Server error" });
  }
});


Orderrouter.get("/api/allorders",async(req,res)=>{
  try{
    const orders = await Order.find();
    res.status(200).json({orders:orders});

  }catch(e){
    res.status(500).json({error:"Server error"});
  }
});


//month-wise orders
Orderrouter.get("/api/:userId/monthly-orders", async (req, res) => {
  const userId = req.params.userId;
  try {
    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ error: "Invalid user ID format" });
    }

    const user = await User.findOne({ _id: userId });
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const balance = user.balance;
    const ordersByMonth = await Order.aggregate([
      { $match: { user: new mongoose.Types.ObjectId(userId) } },
      {
        $group: {
          _id: {
            year: { $year: "$orderTime" },
            month: { $month: "$orderTime" },
          },
          orders: { $push: "$$ROOT" },
          totalOrders: { $sum: 1 },
        },
      },
      { $sort: { "_id.year": 1, "_id.month": 1 } } 
    ]);

    const currentYear = new Date().getFullYear();
    const allMonths = Array.from({ length: 12 }, (_, i) => ({
      _id: { year: currentYear, month: i + 1 },
      orders: [],
      totalOrders: 0,
    }));

    const completeOrdersByMonth = allMonths.map(month => {
      const found = ordersByMonth.find(
        order => order._id.year === month._id.year && order._id.month === month._id.month
      );
      return found || month;
    });

    let totalOrdersCount = 0;
    let totalExpenditure = 0;
    
    const transformedMonthlyOrders = await Promise.all(
      completeOrdersByMonth.map(async (monthData) => {
        const transformedOrders = await Promise.all(
          monthData.orders.map(async (order) => {
            const orderObj = order.toObject ? order.toObject() : order;
            const orderDate = new Date(orderObj.orderTime);
            const format = orderDate.toLocaleDateString("en-GB", {
              day: "2-digit",
              month: "2-digit",
              year: "2-digit",
            });
            
            const transformedItems = await Promise.all(
              orderObj.items.map(async (item) => {
                const foodItem = await Menu.findById(item.foodItem);
                return {
                  ...item,
                  foodItemName: foodItem ? foodItem.name : "Unknown Item",
                  foodItemCategory: foodItem ? foodItem.category : "Unknown Category",
                  foodItemId: foodItem ? foodItem._id : null,
                  foodItem: undefined,
                };
              })
            );
            
            totalOrdersCount++;
            totalExpenditure += orderObj.totalPrice;
            
            return {
              ...orderObj,
              formatDate: format,
              balance,
              items: transformedItems,
            };
          })
        );
        
        return {
          ...monthData,
          orders: transformedOrders,
        };
      })
    );

    res.status(200).json({
      monthlyOrders: transformedMonthlyOrders,
      totalOrdersCount,
      totalExpenditure,
    });
  } catch (err) {
    console.error("Error in monthly-orders route:", err);
    res.status(500).json({ error: "Server error", details: err.message });
  }
});

module.exports = Orderrouter;
