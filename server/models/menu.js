const mongoose = require("mongoose");

const menuSchema = mongoose.Schema({
    name: {
        required: true,
        type: String
    },
    description: {
        type: String
    },
    category: {
        type: String
    },
    price: {
        type: Number,
        required: true
    },
    availability: {
        type: Boolean,
        required: true
    }
});

const Menu = mongoose.model("Menu", menuSchema);
module.exports = Menu;
