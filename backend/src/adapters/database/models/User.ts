import { IUser } from "../../../domain/entities/User";
import mongoose from 'mongoose';

const UserSchema = new mongoose.Schema<IUser>({
  username: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
  games: [{
    game: { type: mongoose.Schema.Types.ObjectId, ref: 'Game' },
    favorite: { type: Boolean, required: true, default: false },
  }],
});

export const User = mongoose.model<IUser>('User', UserSchema);
  