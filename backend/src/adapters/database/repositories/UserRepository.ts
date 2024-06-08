import { IUserRepository } from "../../../domain/ports/User";

export class UserRepository implements IUserRepository {
  create(username: string, email: string, password: string): Promise<void> {
    throw new Error("Method not implemented.");
  }
  update(id: import("mongoose").Types.ObjectId, username: string, email: string, password: string): Promise<void> {
    throw new Error("Method not implemented.");
  }
  delete(id: import("mongoose").Types.ObjectId): Promise<void> {
    throw new Error("Method not implemented.");
  }
  findById(id: import("mongoose").Types.ObjectId): Promise<import("../../../domain/entities/User").User | null> {
    throw new Error("Method not implemented.");
  }
  findByEmail(email: string): Promise<import("../../../domain/entities/User").User | null> {
    throw new Error("Method not implemented.");
  }
  findAll(): Promise<import("../../../domain/entities/User").User[]> {
    throw new Error("Method not implemented.");
  }
}