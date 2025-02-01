import mongoose from "mongoose";

const messMenuSchema = new mongoose.Schema({
  kitchenName: {
    type: String,
    required: true,
  },
  messMenu: {
    type: Map,
    of: {
      type: Map,
      of: [String],
    },
    required: true,
  },
});

const MessMenu = mongoose.model("MessMenu", messMenuSchema);

export default MessMenu;
