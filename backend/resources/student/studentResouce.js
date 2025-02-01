import Student from "../../models/student.js";
import express from "express";
import * as messages from "../../constants/messages.js";
import tokenRequired from "../../middlewares/tokenRequired.js";

const studentRouter = express.Router();

studentRouter.get("/:id", tokenRequired, async (req, res) => {
  const studentId = req.params.id;

  try {
    const student = await Student.findById(studentId);

    if (!student) {
      return res.status(404).json({ message: messages.userNotFound });
    }

    res.json(student);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

studentRouter.put("/:id", async (req, res) => {
  const studentId = req.params.id;
  const studentData = req.body;

  try {
    const updatedStudent = await Student.findByIdAndUpdate(
      studentId,
      studentData,
      { new: true }
    );
    res.json(updatedStudent);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: messages.internalServerError });
  }
});

studentRouter.delete("/:id", async (req, res) => {
  const studentId = req.params.id;

  try {
    const deletedStudent = await Student.findByIdAndDelete(studentId);
      // .populate("skills")
      // .populate("achievements");
    res.json(deletedStudent);
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default studentRouter;
