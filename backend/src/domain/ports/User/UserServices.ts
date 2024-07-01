import { IUser } from "../../entities/User";

export interface IUserServices {
  searchUsers(username: string): Promise<IUser | IUser[] | null>;
  findById(userId: string): Promise<IUser | null>;
}
