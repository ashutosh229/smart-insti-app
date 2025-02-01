import { Router } from "express";
import Room from "../../models/room.js";
import * as messages from "../../constants/messages.js";
const router = Router();

// GET method
router.get("/", async (req, res) => {
  // Your code here
  const rooms = await Room.find({});
  res.send(rooms);
});

// POST method
router.post("/", async (req, res) => {
  try {
    // Extract data from request body
    const { name, vacant, occupantId, occupantName } = req.body;

    // Create a new room instance
    const newRoom = new Room({
      name,
      vacant: vacant || true, // Set default value if not provided
      occupantId: occupantId || null, // Set default value if not provided
      occupantName: occupantName || null, // Set default value if not provided
    });

    // Save the new room to the database
    await newRoom.save();

    // Respond with success message
    res.status(201).json({ message: messages.roomCreated, room: newRoom });
  } catch (error) {
    // Handle errors
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default router;
