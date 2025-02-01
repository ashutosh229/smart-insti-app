import Achievement from "../../models/achievement.js";
import express from "express";
import * as messages from "../../constants/messages.js";
const achievementRouter = express.Router();

achievementRouter.get("/achievements", async (req, res) => {
  try {
    const achievement = await Achievement.find({});
    res.json(achievement);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

achievementRouter.get("/achievements/:id", async (req, res) => {
  const achievementId = req.params.id;

  try {
    const achievementDetails = await Achievement.findById(achievementId);

    if (!achievementDetails) {
      return res.status(404).json({ message: messages.achievementNotFound });
    }

    res.json(achievementDetails);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

achievementRouter.post("/achievements", async (req, res) => {
  const achievementData = req.body;

  try {
    const newAchievement = new Achievement(achievementData);
    await newAchievement.save();

    res.status(201).json(newAchievement);
  } catch (err) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

achievementRouter.put("/achievements/:id", async (req, res) => {
  const achievementId = req.params.id;
  const achievementData = req.body;

  try {
    const updatedAchievement = await Achievement.findByIdAndUpdate(
      achievementId,
      achievementData,
      { new: true }
    );
    res.json(updatedAchievement);
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

achievementRouter.delete("/achievements/:id", async (req, res) => {
  const achievementId = req.params.id;

  try {
    const deletedAchievement = await Achievement.findByIdAndDelete(
      achievementId
    );
    res.json(deletedAchievement);
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default achievementRouter;
