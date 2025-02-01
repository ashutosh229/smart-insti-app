import express from "express";
import * as messages from "../../constants/messages.js";
import Student from "../../models/student.js";
import Faculty from "../../models/faculty.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

const generalAuthRouter = express.Router();
dotenv.config();

generalAuthRouter.post("/login", async (req, res) => {
  try {
    const { email, loginForRole } = req.body;

    let userCollection;

    switch (loginForRole) {
      case "student":
        userCollection = Student;
        break;
      case "faculty":
        userCollection = Faculty;
        break;
      default:
        return res.status(400).send({ error: messages.invalidUserType });
    }

    const user = await userCollection.findOne({ email });
    const token = jwt.sign({ id: user._id }, process.env.ACCESS_TOKEN_SECRET);

    res.send({
      token: token,
      _id: user._id,
      name: user.name,
      email: user.email,
      role: loginForRole,
    });
  } catch (e) {
    res.status(500).json({ error: messages.internalServerError });
  }
});

export default generalAuthRouter;
