const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name:{
        required:true,
        type:String
    },
    img:{
        type:String,
    },
    username:{
        required:true,
        type:String,
        unique:true
    },
    password:{
        required:true,
        type:String
    },
    department:{
        type:String
    },
    role:{
        required:true,
        type:String
    },
    balance:{
        type:Number  
    }
    
});


const User = mongoose.model("User",userSchema);
module.exports = User;