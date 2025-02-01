import { Router } from "express";
import Room from "../../models/room.js";
import * as messages from "../../constants/messages.js";
const router = Router();

// PUT method
router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { occupantName, occupantId, vacant } = req.body;
    const room = await Room.findById(id);
    if (!room) {
      return res.status(404).json({ message: messages.roomNotFound });
    }

    if (vacant) {
      room.vacant = true;
      room.occupantId = null;
      room.occupantName = null;
    } else {
      room.vacant = false;
      room.occupantId = occupantId;
      room.occupantName = occupantName;
    }

    await room.save();

    res.json({ message: messages.roomUpdated, room });
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default router;
