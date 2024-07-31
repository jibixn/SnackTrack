const mongoose = require('mongoose');

const orderItemSchema = new mongoose.Schema({
  foodItem: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Menu',
    required: true
  },
  quantity: {
    type: Number,
    required: true,
    min: 1
  },
  price: {
    type: Number,
    required: true
  }
});

const orderSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  items: [orderItemSchema],
  totalPrice: {
    type: Number,
    required: true
  },
  status: {
    type: String,
    enum: ['pending','confirmed','Paid','edited','tchrConfirmed'],
    default: 'pending'
  },
  orderTime: {
    type: Date,
    default: Date.now
  },
}, {
  timestamps: true
});




const Order = mongoose.model("Order", orderSchema);

module.exports = mongoose.models.Order || mongoose.model("Order", orderSchema);
