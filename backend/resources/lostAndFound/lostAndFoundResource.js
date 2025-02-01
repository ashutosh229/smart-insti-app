import express from "express";
import * as messages from "../../constants/messages.js";
import LostAndFoundItem from "../../models/lost_and_found.js";
import fs from "fs";

const lostAndFoundRouter = express.Router();

// DELETE item by id
lostAndFoundRouter.delete("/:id", async (req, res) => {
  const itemId = req.params.id;

  try {
    const item = await LostAndFoundItem.findByIdAndDelete(itemId);

    if (!item) {
      return res.status(404).json({ message: messages.itemNotFound });
    }

    // Delete the image file
    fs.unlink(item.imagePath, (err) => {
      if (err) {
        console.error(err);
      }
    });

    res.json(item);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default lostAndFoundRouter;
