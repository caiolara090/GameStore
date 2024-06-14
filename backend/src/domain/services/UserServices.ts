import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { UserSearchResult } from "../entities/User";
import { IUserRepository } from "../ports/User";
import { IUserServices } from "../ports/User/UserServices";

export class UserServices implements IUserServices {
  async searchUsers(
    username: string,
    fields: string,
    page: number,
    limit: number
  ): Promise<UserSearchResult | null> {
    const userRepository: IUserRepository = new UserRepository();

    return await userRepository.searchUsers(username, fields, page, limit);
  }
}
