import mongoose from "mongoose";
import { IReview } from "../../../domain/entities/Review";

const ReviewSchema = new mongoose.Schema<IReview>({
  title: { type: String, required: true },
  description: { type: String, required: true },
  rating: { type: Number, required: true },
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  game: { type: mongoose.Schema.Types.ObjectId, ref: 'Game' },
});

export const ReviewModel = mongoose.model<IReview>('Review', ReviewSchema);
