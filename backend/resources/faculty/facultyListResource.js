import Faculty from "../../models/faculty.js";
import express from "express";
import * as messages from "../../constants/messages.js";

const facultyListResource = express.Router();

facultyListResource.get("/", async (req, res) => {
  try {
    const faculties = await Faculty.find()
    res.json(faculties);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

facultyListResource.post("/", async (req, res) => {
  const { email } = req.body;
  let existingUser = await Faculty.findOne({ email });
  try {
    if (!existingUser) {
      const newUser = new Faculty({ email });
      await newUser.save();
      res.send({ message: messages.userCreated, user: newUser });
    } else {
      res.send({
        message: messages.userAlreadyExists,
        user: existingUser,
      });
    }
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default facultyListResource;
