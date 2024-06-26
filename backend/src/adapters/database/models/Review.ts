import mongoose from "mongoose";
import { IReview } from "../../../domain/entities/Review";

const ReviewSchema = new mongoose.Schema<IReview>({
  description: { type: String, required: true },
  rating: { type: Number, required: true, min: 1, max: 5 },
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } as unknown as mongoose.SchemaDefinitionProperty<string>, // Para o TypeScript aceitar string na interface e ObjectId no schema
  gameId: { type: mongoose.Schema.Types.ObjectId, ref: 'Game' } as unknown as mongoose.SchemaDefinitionProperty<string>,
});

export const ReviewModel = mongoose.model<IReview>('Review', ReviewSchema);
