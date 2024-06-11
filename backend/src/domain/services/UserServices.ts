import { IUserRepository } from "../ports/User";
import { IUserServices } from "../ports/User/UserServices";

export class UserServices implements IUserServices {
  constructor(private readonly userRepository: IUserRepository) {}

  async checkCredentials(username: string, password: string): Promise<boolean> {
    const user = await this.userRepository.findByUsername(username);
    if (!user) throw new Error("User not found");
    return user.password === password;
  }
}
