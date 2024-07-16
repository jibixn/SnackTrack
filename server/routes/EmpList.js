const express = require('express');
const fetchEmpRouter = express.Router();
const User = require('../models/User');


fetchEmpRouter.get('/api/EmpList',async (req,res)=>{
    try{
        const list=await User.find({});
        res.status(200).json({list:list});

    }catch(e){
        res.status(500).json({ error: error.message });
    }


})

module.exports = fetchEmpRouter;