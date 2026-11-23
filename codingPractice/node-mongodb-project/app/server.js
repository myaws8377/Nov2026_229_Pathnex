
const express = require("express");
const mongoose = require("mongoose");

const app = express();

app.use(express.json());

const PORT = process.env.PORT || 3000;
const MONGO_URI = process.env.MONGO_URI;

const User = mongoose.model(
  "User",
  new mongoose.Schema({
    name: { type: String, required: true }
  })
);

app.get("/", (req, res) => {
  res.json({
    message: "Node.js application is running!",
    database: mongoose.connection.readyState === 1
      ? "connected"
      : "disconnected"
  });
});

app.post("/users", async (req, res) => {
  try {
    const user = await User.create({
      name: req.body.name
    });

    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.get("/users", async (req, res) => {
  const users = await User.find();
  res.json(users);
});

async function startServer() {
  try {
    await mongoose.connect(MONGO_URI, {
      serverSelectionTimeoutMS: 5000
    });

    console.log("MongoDB connected");

    app.listen(PORT, "0.0.0.0", () => {
      console.log(`Server running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Application startup failed:", error);
    process.exit(1);
  }
}

startServer();