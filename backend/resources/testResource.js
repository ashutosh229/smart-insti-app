import { Router } from "express";
const router = Router();

// GET method
router.get("/", (req, res) => {
  // Your code here
  res.send("GET request received");
});

// POST method
router.post("/", (req, res) => {
  // Your code here
  res.send("POST request received");
});

// PUT method
router.put("/:id", (req, res) => {
  // Your code here
  res.send("PUT request received " + req.params.id);
});

// DELETE method
router.delete("/:id", (req, res) => {
  // Your code here
  res.send("DELETE request received " + req.params.id);
});

export default router;
