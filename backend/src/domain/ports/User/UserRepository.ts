import { IUser } from "../../entities/User";

export interface IUserRepository {
  create(user: IUser): Promise<IUser>;
  update(_id: string, user: Partial<IUser>): Promise<IUser>;
  delete(_id: string): Promise<void>;
  find(user: Partial<IUser>): Promise<IUser | IUser[] | null>;
};
