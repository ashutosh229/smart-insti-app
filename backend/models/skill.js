import mongoose from 'mongoose';

const skillSchema = new mongoose.Schema({
  name: { type: String, required: true },
  level: { type: Number, required: true },
});

const Skill = mongoose.model('Skill', skillSchema);
export default Skill;