import { User } from "../../entities/User";
import { Types } from 'mongoose';

export interface IUserRepository {
  create(username: string, email: string, password: string): Promise<void>;
  update(id: Types.ObjectId, username: string, email: string, password: string): Promise<void>;
  delete(id: Types.ObjectId): Promise<void>;
  findById(id: Types.ObjectId): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  findAll(): Promise<User[]>;
};
