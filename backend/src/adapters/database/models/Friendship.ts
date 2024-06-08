import mongoose from "mongoose";
import { IFriendship } from "../../../domain/entities/Friendship";

const FriendshipSchema = new mongoose.Schema<IFriendship>({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  friend: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
});

export const Friendship = mongoose.model<IFriendship>('Friendship', FriendshipSchema);
