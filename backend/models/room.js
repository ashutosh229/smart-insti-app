import mongoose from "mongoose";

const roomSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  vacant: {
    type: Boolean,
    default: true,
  },
  occupantId: {
    type: String,
    default: null,
  },
  occupantName: {
    type: String,
    default: null,
  },
});

const Room = mongoose.model("Room", roomSchema);

export default Room;
