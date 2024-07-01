import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IUser } from "../entities/User";
import { IUserRepository } from "../ports/User/UserRepository";
import { IUserServices } from "../ports/User/UserServices";

export class UserServices implements IUserServices {
  private userRepository: IUserRepository;

  constructor() {
    this.userRepository = new UserRepository();
  }

  async searchUsers(username: string): Promise<IUser | IUser[] | null> {
    const query = {} as any;
    query.username = { $regex: username, $options: "iu" };

    return await this.userRepository.find(query);
  }

  async findById(userId: string): Promise<IUser | null> {
    return await this.userRepository.findById(userId);
  }
}
