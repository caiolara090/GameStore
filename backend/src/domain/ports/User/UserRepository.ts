import { IUser, UserSearchResult } from "../../entities/User";

export interface IUserRepository {
  create(user: IUser): Promise<IUser>;
  update(_id: string, user: Partial<IUser>): Promise<IUser>;
  delete(_id: string): Promise<void>;
  find(user: Partial<IUser>): Promise<IUser | IUser[] | null>;
  findByEmail(email: string): Promise<IUser | null>;
  findByUsername(username: string): Promise<IUser | null>;
  findById(_id: string): Promise<IUser | null>;
  find(user: Partial<IUser>): Promise<IUser | IUser[] | null>;
  searchUsers(
    user: string,
    fields: string,
    page: number,
    limit: number
  ): Promise<UserSearchResult | null>;
  searchUsersLibrary(
    username: string,
    gameTitle: string,
    fields: string,
    page: number,
    limit: number
  ): Promise<UserSearchResult | null>;
}
