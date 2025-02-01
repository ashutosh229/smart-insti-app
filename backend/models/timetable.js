import mongoose from "mongoose";

const timetableSchema = new mongoose.Schema({
  id: String,
  name: {
    type: String,
    required: true,
  },
  rows: {
    type: Number,
    required: true,
  },
  columns: {
    type: Number,
    required: true,
  },
  creatorId: {
    type: String,
    required: true,
  },
  timeRanges: [
    {
      start: {
        hour: {
          type: Number,
          required: true,
        },
        minute: {
          type: Number,
          required: true,
        },
      },
      end: {
        hour: {
          type: Number,
          required: true,
        },
        minute: {
          type: Number,
          required: true,
        },
      },
    },
  ],
  timetable: [
    [
      {
        type: String,
      },
    ],
  ],
});

const Timetable = mongoose.model("Timetable", timetableSchema);

export default Timetable;
