import Message from '../../models/message.js';
import * as messages from "../../constants/messages.js";
import { Router} from "express";
const messageListRouter = Router();

messageListRouter.get("/", async (req, res) => {
    try {
        const messages = await Message.find({});
        res.json(messages);
    } catch (err) {
        res.status(500).json({ message: messages.internalServerError });
    }
}); 

messageListRouter.post("/", async (req, res) => {
    const message = new Message({
        sender: req.body.sender,
        content: req.body.content,
        timestamp: req.body.timestamp
    });
    try {
        const newMessage = await message.save();
        res.status(201).json(newMessage);
    } catch (err) {
        res.status(400).json({ message: messages.badRequest });
    }
});

messageListRouter.delete("/:id", async (req, res) => {
    try {
        const message = await Message.findById(req.params.id);
        console.log(message);
        if (message) {
            await message.deleteOne();
            res.json({ message: messages.deleted });
        } else {
            res.status(404).json({ message: messages.notFound });
        }
    } catch (err) {
        res.status(500).json({ message: messages.internalServerError });
    }
});

export default messageListRouter;