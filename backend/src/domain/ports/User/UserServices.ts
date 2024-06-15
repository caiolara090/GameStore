import { UserSearchResult } from "../../entities/User";

export interface IUserServices {
  searchUsers(
    username: string,
    fields: string,
    page?: number,
    limit?: number
  ): Promise<UserSearchResult | null>;

  searchUsersLibrary(
    username: string,
    gameTitle: string,
    fields: string,
    page?: number,
    limit?: number
  ): Promise<UserSearchResult | null>;
}
