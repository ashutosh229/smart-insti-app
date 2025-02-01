import mongoose from 'mongoose';

const achievementSchema = new mongoose.Schema({
  name: { type: String, required: true },
  date: { type: Date, required: true },
  description: { type: String, required: true },
});

const Achievement = mongoose.model('Achievement', achievementSchema);
export default Achievement;