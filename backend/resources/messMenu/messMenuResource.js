import express from "express";
import * as messages from "../../constants/messages.js";
import MessMenu from "../../models/mess_menu.js";

const messMenuRouter = express.Router();

// PUT method
messMenuRouter.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { messMenu } = req.body;
    const currentMenu = await MessMenu.findById(id);

    if (!currentMenu) {
      return res.status(404).json({ message: messages.messMenuNotFound });
    }

    currentMenu.messMenu = messMenu;
    await currentMenu.save();

    res.json({ message: messages.messMenuUpdated });
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

//DELETE method
messMenuRouter.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    await MessMenu.findByIdAndDelete(id);

    res.json({ message: messages.deleted });
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default messMenuRouter;
