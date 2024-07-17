const express = require('express');
const fetchMenuRouter = express.Router();
const Menu = require('../models/menu');

fetchMenuRouter.get("/api/getmenu", async (req, res) => {
    try {
       const menuItems = await Menu.find({});
       res.status(200).json({ message: "Menu fetched successfully", menu: menuItems });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = fetchMenuRouter;

