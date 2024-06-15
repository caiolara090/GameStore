import { IUser, IUserGame } from "../../entities/User";

export interface IUserRepository {
  create(user: IUser): Promise<IUser>;
  update(_id: string, user: Partial<IUser>): Promise<IUser>;
  delete(_id: string): Promise<void>;
  find(user: Partial<IUser>): Promise<IUser | IUser[] | null>;
  findByEmail(email: string): Promise<IUser | null>;
  findByUsername(username: string): Promise<IUser | null>;
  findById(_id: string): Promise<IUser | null>;
  find(user: Partial<IUser>): Promise<IUser | IUser[] | null>;
  searchUsers(user: string, fields: string): Promise<IUser[] | null>;
  searchUsersLibrary(userId: string, title: string): Promise<IUserGame[]>;
  toggleUsersGameFavorite(userId: string, gameId: string, isFavorite: boolean): Promise<void>;
}
