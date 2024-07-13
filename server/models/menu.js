const mongoose = require("mongoose");

const menuSchema = mongoose.Schema({
    name: {
        required: true,
        type: String
    },
    description: {
        type: String
    },
    img:{
        type:String,
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
    },
    qty:{
        type:Number,
    }
});

module.exports = mongoose.models.Menu || mongoose.model("Menu", menuSchema);
