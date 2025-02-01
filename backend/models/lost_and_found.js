import mongoose from "mongoose";

const lostAndFoundItemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  lastSeenLocation: {
    type: String,
  },
  imagePath: {
    type: String,
    nullable: true,
  },
  description: {
    type: String,
  },
  contactNumber: {
    type: String,
    required: true,
  },
  listerId: {
    type: String,
    required: true,
  },
  isLost: {
    type: Boolean,
    required: true,
  },
});

const LostAndFoundItem = mongoose.model(
  "LostAndFoundItem",
  lostAndFoundItemSchema
);

export default LostAndFoundItem;
