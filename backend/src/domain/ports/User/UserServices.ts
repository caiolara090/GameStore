import { IUser, IUserGame } from "../../entities/User";

export interface IUserServices {
  searchUsers(username: string, fields: string): Promise<IUser[] | null>;
  searchUsersLibrary(userId: string, gameTitle: string): Promise<IUserGame[]>;
  toggleUsersGameFavorite(userId: string, gameId: string): Promise<void>;
  findById(userId: string): Promise<IUser | null>;
}
