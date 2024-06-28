import { IUser } from "../../entities/User";

export interface IUserServices {
  searchUsers(username: string, fields: string): Promise<IUser[] | null>;
  findById(userId: string): Promise<IUser | null>;
}
