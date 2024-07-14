const express = require('express');
const Orderrouter = express.Router();
const Order = require('../models/Order');


Orderrouter.get('/api/orders', async (req, res) => {
  const userId = req.user._id;
  try {
  
    const orders = await Order.find({ user: userId });

    const totalOrdersCount = orders.length;
    const totalExpenditure = orders.reduce((total, order) => total + order.totalPrice, 0);

    res.json({
      orders,
      totalOrdersCount,
      totalExpenditure
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = Orderrouter;
