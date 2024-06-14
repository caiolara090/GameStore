import { ObjectId } from "mongoose";
import { SignUpRequest } from "../../entities/User";
import { IUser } from "../../entities/User";

export interface IUserAuthServices {
  signToken(userId: ObjectId): string;
  createUser(body: SignUpRequest): Promise<IUser>;
  findByEmail(body: string): Promise<IUser | IUser[] | null>;
  findByUsername(body: string): Promise<IUser | IUser[] | null>;
}
