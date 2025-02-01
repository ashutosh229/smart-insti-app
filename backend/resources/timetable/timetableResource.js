import express from "express";
import * as messages from "../../constants/messages.js";
import Timetable from "../../models/timetable.js";
import tokenRequired from "../../middlewares/tokenRequired.js";
const timetableRouter = express.Router();

// POST create a new timetable
timetableRouter.post("/", tokenRequired, async (req, res) => {
  try {
    const newTimetable = new Timetable(req.body);
    const savedTimetable = await newTimetable.save();
    res.json(savedTimetable);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default timetableRouter;
