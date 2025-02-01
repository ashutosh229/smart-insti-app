import { Router } from "express";
import Admin from "../../models/admin.js";
import tokenRequired from "../../middlewares/tokenRequired.js";

const adminResource = Router();

//GET admin by id
adminResource.get("/:id", tokenRequired, async (req, res) => {
  try {
    const admin = await Admin.findById(req.params.id);
    res.json(admin);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});

export default adminResource;
