import mongoose from 'mongoose';
const studentSchema = new mongoose.Schema({
    name: {
        type: String,
        default: 'Smart Insti User'
    },
    email: {
        type: String,
        required: true
    },
    rollNumber: {
        type: String,
    },
    about: {
        type: String,
    },
    profilePicURI: {
        type: String,
    },
    branch: {
        type: String,
    },
    graduationYear: {
        type: Number,
    },
    skills: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Skill'
    }],
    achievements: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Achievement'
    }],
    roles: {
        type: [String],
    }
});

const Student = mongoose.model('Student', studentSchema);

export default Student;
