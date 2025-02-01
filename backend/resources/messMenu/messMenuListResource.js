import express from "express";
import * as messages from "../../constants/messages.js";
import MessMenu from "../../models/mess_menu.js";

const messMenuListRouter = express.Router();

// GET method
messMenuListRouter.get("/", async (req, res) => {
  try {
    const messMenuData = await MessMenu.find();
    res.json(messMenuData);
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

// POST method
messMenuListRouter.post("/", async (req, res) => {
  try {
    const { kitchenName, messMenu } = req.body;
    const newMessMenu = new MessMenu({ kitchenName, messMenu });
    await newMessMenu.save();
    res.json({ message: messages.messMenuAdded, newMessMenu });
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default messMenuListRouter;
