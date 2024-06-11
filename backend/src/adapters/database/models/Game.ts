import mongoose from "mongoose";
import { IGame } from "../../../domain/entities/Game";

const GameSchema = new mongoose.Schema<IGame>({
  name: { type: String, required: true },
  description: { type: String, required: true },
  image: { type: String, required: true },
  price: { type: Number, required: true },
  reviews: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Review' }],
});

export const GameModel = mongoose.model<IGame>('Game', GameSchema);
