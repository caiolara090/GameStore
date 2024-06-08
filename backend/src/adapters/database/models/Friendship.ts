import mongoose from "mongoose";
import { IFriendship } from "../../../domain/entities/Friendship";

const FriendshipSchema = new mongoose.Schema<IFriendship>({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } as unknown as mongoose.SchemaDefinitionProperty<string>, // Para o TypeScript aceitar string na interface e ObjectId no schema
  friend: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } as unknown as mongoose.SchemaDefinitionProperty<string>,
});

export const FriendshipModel = mongoose.model<IFriendship>('Friendship', FriendshipSchema);
