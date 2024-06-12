import { ObjectId } from "mongoose";
import { SignUpRequest } from "../../../adapters/api/middlewares/Auth/SignupValidation";
import { IUser } from "../../entities/User";

export interface IUserAuthServices {
  signToken(userId: ObjectId): string;
  createUser(body: SignUpRequest): Promise<IUser>;
  findByEmail(body: string): Promise<IUser | IUser[] | null>;
  findByUsername(body: string): Promise<IUser | IUser[] | null>;
}
