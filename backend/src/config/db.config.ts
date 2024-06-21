import mongoose from "mongoose";

const uri = process.env.MONGODB_URI as string;

export async function connectToDatabase() {
    try {
      await mongoose.connect(uri, { dbName: "gamestore" });
      console.log('Successfully connected to MongoDB with Mongoose');
    } catch (err) {
      console.error('Failed to connect to MongoDB with Mongoose', err);
      process.exit(1); 
    }
}