import { Router } from "express";
import Admin from "../../models/admin.js";
import dotenv from "dotenv";
import jwt from "jsonwebtoken";
import bcryptjs from "bcryptjs";
import * as messages from "../../constants/messages.js";

const adminAuthRouter = Router();
dotenv.config();

// Sign-Up Route
adminAuthRouter.post("/register", async (req, res) => {
  try {
    const { email, password } = req.body;
    const existingUser = await Admin.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: messages.userAlreadyExists });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    let admin = new Admin({
      email,
      password: hashedPassword,
    });

    admin = await admin.save();

    res.json(admin);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign-In Route
adminAuthRouter.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await Admin.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: messages.userNotFound });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: messages.incorrectPassword });
    }

    const token = jwt.sign({ id: user._id }, process.env.ACCESS_TOKEN_SECRET);
    res.json({
      token: token,
      _id: user._id,
      name: user.name,
      email: user.email,
      role: "admin",
    });
  } catch (e) {
    res.status(500).json({ error: messages.internalServerError });
  }
});

export default adminAuthRouter;
