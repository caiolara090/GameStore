import { IUser } from "../../../domain/entities/User";
import mongoose from "mongoose";

const UserSchema = new mongoose.Schema<IUser>({
  username: { type: String, required: true },
  age: { type: Number, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
  games: [
    {
      game: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Game",
      } as unknown as mongoose.SchemaDefinitionProperty<string>, // Para o TypeScript aceitar string na interface e ObjectId no schema
      favorite: { type: Boolean, required: true, default: false },
    },
  ] as unknown as mongoose.SchemaDefinitionProperty<[]>, // Faz o valor padrão ser uma string vazia
  credits: { type: Number, default: 0 },
});

export const UserModel = mongoose.model<IUser>("User", UserSchema);
