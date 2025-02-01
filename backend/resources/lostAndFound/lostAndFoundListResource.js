import { Router } from "express";
import LostAndFoundItem from "../../models/lost_and_found.js";
import fs from "fs/promises";
import uploader from "../../middlewares/multerConfig.js";
import * as messages from "../../constants/messages.js";

const router = Router();

// GET method to retrieve all items
router.get("/", async (req, res) => {
  try {
    // Query the database to retrieve all items
    const items = await LostAndFoundItem.find({});

    // Create an empty array to store items with images
    const itemsWithImages = [];

    // Iterate through each item
    for (const item of items) {
      // Check if imagePath is null
      let imagePathBase64 = null;
      if (item.imagePath) {
        // Read the image file if imagePath is not null
        const bufferImage = await fs.readFile(item.imagePath);
        imagePathBase64 = bufferImage.toString("base64");
      }

      // Create a new object with the required attributes
      const itemWithImage = {
        _id: item._id,
        name: item.name,
        lastSeenLocation: item.lastSeenLocation,
        imagePath: imagePathBase64, // Set imagePath to null if null in the database
        description: item.description,
        contactNumber: item.contactNumber,
        listerId: item.listerId,
        isLost: item.isLost,
      };

      // Push the item with image to the array
      itemsWithImages.push(itemWithImage);
    }

    // Send the response with the items
    res.json(itemsWithImages);
  } catch (error) {
    // Handle errors
    res.status(500).json({ message: messages.internalServerError });
  }
});

// POST method
router.post("/", uploader.single("image"), async (req, res) => {
  try {
    // Access the uploaded file using req.file
    const file = req.file;

    // Construct the LostAndFoundItem object with data from the request
    const newItem = new LostAndFoundItem({
      name: req.body.name,
      lastSeenLocation: req.body.lastSeenLocation,
      imagePath: file ? file.path : null,
      description: req.body.description,
      contactNumber: req.body.contactNumber,
      listerId: req.body.listerId,
      isLost: req.body.isLost,
    });

    // Save the new item to the database
    await newItem.save();

    res.json({ message: messages.itemAdded });
  } catch (error) {
    res.status(500).json({ message: messages.internalServerError });
  }
});

export default router;
