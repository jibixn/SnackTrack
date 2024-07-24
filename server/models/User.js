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
        type:Number, 
        default:0 
    }
    
});

userSchema.set('toJSON', {
    transform: function(doc, ret, opt) {
        delete ret['password'];
        return ret;
    }
  });

const User = mongoose.model("User",userSchema);
module.exports = User;