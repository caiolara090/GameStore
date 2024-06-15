import { ObjectId } from "mongoose";
import { sign } from "../../utils/Token";
import { IUserAuthServices } from "../ports/User/UserAuthServices";
import { IUser } from "../entities/User";
import { IUserRepository } from "../ports/User/UserRepository";
import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import bcrypt from "bcryptjs";
import { SignUpRequest } from "../../adapters/api/middlewares/Auth/SignupValidation";

export class UserAuthServices implements IUserAuthServices {
  signToken = (userId: ObjectId): string => {
    const accessToken = sign({ uid: userId });

    if (accessToken === "JWT_SECRET_NOT_FOUND") {
      throw new Error("Internal Server Error");
    }
    return accessToken;
  };

  async createUser(body: SignUpRequest): Promise<IUser> {
    const userRepository: IUserRepository = new UserRepository();

    body.password = bcrypt.hashSync(body.password);
    return await userRepository.create(body);
  }

  async findByEmail(email: string): Promise<IUser | IUser[] | null> {
    const userRepository: IUserRepository = new UserRepository();

    return await userRepository.find({ email: email });
  }

  async findByUsername(username: string): Promise<IUser | IUser[] | null> {
    const userRepository: IUserRepository = new UserRepository();

    return await userRepository.find({ username: username });
  }
}
