import mongoose from "mongoose";
import dotenv from "dotenv";

// Add a .env file to the root to access the mongoDB credentials
dotenv.config();

const Connection = () => {
  mongoose.connect(process.env.MONGODB_URI);

  mongoose.connection.on("connected", () => {
    console.log("Database connected Successfully");
  });

  mongoose.connection.on("disconnected", () => {
    console.log("Database disconnected");
  });

  mongoose.connection.on("error", () => {
    console.log("Error while connecting with the database ", error.message);
  });
};

export default Connection;
