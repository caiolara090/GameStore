import { ObjectId } from "mongoose";
import { IUser } from "../../entities/User";
import { SignUpRequest } from "../../../adapters/api/middlewares/Auth/SignupValidation";

export interface IUserAuthServices {
  signToken(userId: ObjectId): string;
  createUser(body: SignUpRequest): Promise<IUser>;
  findByEmail(body: string): Promise<IUser | IUser[] | null>;
  findByUsername(body: string): Promise<IUser | IUser[] | null>;
}
