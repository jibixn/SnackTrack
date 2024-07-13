const express = require("express");
const menuRouter = express.Router();
const Menu = require('../models/menu');

menuRouter.post("/api/menu", async (req, res) => {
    try {
        const menuDetails = {
            name: "Idiyappam",
            description: "",
            category: "Lunch",
            price: 8,
            availability: true,
            qty:5
        };

        const newMenuItem = new Menu(menuDetails);
        await newMenuItem.save();

        res.status(201).json({ message: "Menu item created successfully", menu: newMenuItem });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = menuRouter;
