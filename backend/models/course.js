import mongoose from 'mongoose';

const courseSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    courseCode: {
        type: String,
        required: true,
        unique: true
    },
    primaryRoom: {
        type: String,
    },
    credits: {
        type: Number,
        required: true,
    },
    professorId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Faculty',
        required: true,
    },
    branches: [{
        type: String,
        required: true
    }]
});

const Course = mongoose.model('Course', courseSchema);

export default Course;