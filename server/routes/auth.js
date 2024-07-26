const express = require("express");
const authRouter = express.Router();
const bcryptjs= require ("bcryptjs");
const jwt = require ("jsonwebtoken");

const User= require('../models/User');




authRouter.post("/api/Signup",async (req,res) =>{
    try{
        const {name,img,username,password,department,role} = req.body;
        const existingUser=await User.findOne({username});
        if(existingUser){
            return res.status(400)
            .json({message:"User Already Exists"});
        }
        const hashed = await bcryptjs.hash(password,8);
        let user = new User({
            name,
            img,
            username,
            password:hashed,
            department,
            role
        })
        user=await user.save();
        res.json(user);
    }catch(e){
        res.status(500).json({message:"Server Error"});

    }

});

authRouter.post("/api/Signin",async (req,res) =>{
    try{
        const {username,password} = req.body;

        const user =await User.findOne({username});

        if(!user){
            return res.status(400)
            .json({message:"User Does not Exist"});
        }

        const match =await bcryptjs.compare(password , user.password);

        if(!match){
            return res.status(400)
            .json({message:"Incorrect Password"})
        }

        const token = jwt.sign({id: user._id },"passwordKey");
        const role=user.role;
        const image=user.img;

        
        res.json({role,token,image,...user._doc});

       




    }catch(e){
        res.status(500).json({error:e.message});

    }

});

authRouter.post('/api/UpdatePass',async (req,res)=>{
    try{

        const {username,password,newPass} = req.body;
        const user= await User.findOne({username});
        if(!user){
            return res.status(400)
            .json({message:"User Does not Exist"});
        }
        
        const match =await bcryptjs.compare(password , user.password);
        
        if(!match){
            return res.status(400)
            .json({message:"Incorrect Password"})
        }
        
        const hashedNewPass = await bcryptjs.hash(newPass, 10);
        user.password = hashedNewPass;

        await user.save();
        res.status(200).json({message:"Password Updated Successfully"});
    }catch(e){
        res.status(500).json({message:"Server Error"+e});
    }




})

module.exports = authRouter;