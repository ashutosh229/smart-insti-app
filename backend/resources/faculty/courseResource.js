import Course from "../../models/course.js";
import express from "express";
import * as messages from "../../constants/messages.js";
const courseRouter = express.Router();

courseRouter.get("/courses", async (req, res) => {
  try {
    const courses = await Course.find({});
    res.json(courses);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

courseRouter.get("/courses/:id", async (req, res) => {
  const courseId = req.params.id;

  try {
    const courseDetails = await Course.findById(courseId);

    if (!courseDetails) {
      return res.status(404).json({ message: messages.courseNotFound });
    }

    res.json(courseDetails);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

courseRouter.post("/courses", async (req, res) => {
  const courseData = req.body;

  try {
    const newCourse = new Course(courseData);
    await newCourse.save();

    res.status(201).json(newCourse);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

courseRouter.put("/courses/:id", async (req, res) => {
  const courseId = req.params.id;
  const courseData = req.body;

  try {
    const updatedCourse = await Course.findByIdAndUpdate(courseId, courseData, {
      new: true,
    });
    res.json(updatedCourse);
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

courseRouter.delete("/courses/:id", async (req, res) => {
  const courseId = req.params.id;

  try {
    const deletedCourse = await Course.findByIdAndDelete(courseId);
    res.json(deletedCourse);
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default courseRouter;
