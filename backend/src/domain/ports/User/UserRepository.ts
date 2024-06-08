import { User } from "../../entities/User";

export interface IUserRepository {
  create(user: User): Promise<User>;
  update(_id: string, user: Partial<User>): Promise<User>;
  delete(_id: string): Promise<void>;
  find(user: Partial<User>): Promise<User | User[] | null>;
};
