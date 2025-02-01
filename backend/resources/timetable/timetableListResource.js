import express from "express";
import * as messages from "../../constants/messages.js";
import Timetable from "../../models/timetable.js";
import tokenRequired from "../../middlewares/tokenRequired.js";
const timetableListRouter = express.Router();

// GET list of timetables by id
timetableListRouter.get("/:id", tokenRequired, async (req, res) => {
  try {
    const creatorId = req.params.id;
    const timetables = await Timetable.find({ creatorId });
    res.json(timetables);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: messages.internalServerError });
  }
});

//DELETE method
timetableListRouter.delete("/:id", tokenRequired, async (req, res) => {
  try {
    const { id } = req.params;
    const timetable = await Timetable.findByIdAndDelete(id);
    if (!timetable) {
      return res.status(404).json({ error: "Timetable not found" });
    }
    res.json({ message: "Timetable deleted successfully" });
  } catch (error) {
    console.error("Error deleting timetable:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

export default timetableListRouter;
