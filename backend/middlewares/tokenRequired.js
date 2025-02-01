import jwt from "jsonwebtoken";
import dotenv from "dotenv";

const secretKey = process.env.ACCESS_TOKEN_SECRET;
dotenv.config();

const tokenRequired = async (req, res, next) => {
  try {
    const token = req.headers["authorization"];
    if (!token || token == "null" || token == "undefined") {
      return res.status(401).json({ message: "Token is required" });
    }

    // Verify the token
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, decoded) => {
      if (err) {
        return res.status(401).json({ message: "Invalid token" });
      }
      // If token is valid, attach the decoded payload to the request object
      req.user = decoded;
      next();
    });
  } catch (error) {
    res.status(500).json({ message: err.message });
  }
};

export default tokenRequired;
