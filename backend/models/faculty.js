import mongoose from 'mongoose';

const facultySchema = new mongoose.Schema({
    name: {
        type: String,
        default: 'Smart Insti User'
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    cabinNumber: {
        type: String,
    },
    department: {
        type: String,
    },
    courses: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Course'
    }],
    
});

const Faculty = mongoose.model('Faculty', facultySchema);
export default Faculty;