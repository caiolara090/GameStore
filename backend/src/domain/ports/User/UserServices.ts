import { UserSearchResult } from "../../entities/User";

export interface IUserServices {
  searchUsers(
    username: string,
    fields: string,
    page: Number,
    limit: Number
  ): Promise<UserSearchResult | null>;
}
