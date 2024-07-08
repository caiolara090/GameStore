import mongoose from "mongoose";
import { MongoMemoryServer } from 'mongodb-memory-server';

const uri = process.env.MONGODB_URI as string;

export async function connectToDatabase(env: string) {
    try {
      if (env === "test") {
        const mongod = await MongoMemoryServer.create();
        
        process.on('SIGINT', async () => {
          await mongod.stop();
          process.exit();
        });
        
        process.on('SIGTERM', async () => {
          await mongod.stop();
          process.exit();
        });

        const uri = mongod.getUri();
        await mongoose.connect(uri);
        console.log('Successfully connected to MongoDB with Mongoose in test environment');

        return;
      } else {
        await mongoose.connect(uri, { dbName: "gamestore" });
        console.log('Successfully connected to MongoDB with Mongoose');
      }
    } catch (err) {
      console.error('Failed to connect to MongoDB with Mongoose', err);
      process.exit(1); 
    }
}