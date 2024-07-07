import mongoose from "mongoose";
import { IFriendship } from "../../../domain/entities/Friendship";

const FriendshipSchema = new mongoose.Schema<IFriendship>({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } as unknown as mongoose.SchemaDefinitionProperty<string>, // Para o TypeScript aceitar string na interface e ObjectId no schema
  friendId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } as unknown as mongoose.SchemaDefinitionProperty<string>,
  status: { 
    type: Number, 
    required: true,
    enums: [
      0,    // Solicitação enviada
      1,    // Solicitação pendente
      2    // Solicitação aceita
    ],
  },
});

export const FriendshipModel = mongoose.model<IFriendship>('Friendship', FriendshipSchema);
