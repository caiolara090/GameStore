import { IGameRepository } from "../../../domain/ports/Game";
import { Game } from "../../../domain/entities/Game";

export class GameRepository implements IGameRepository {
  create(game: Game): Promise<Game> {
    throw new Error("Method not implemented.");
  }
  update(game: Game): Promise<Game> {
    throw new Error("Method not implemented.");
  }
  delete(id: import("mongoose").Types.ObjectId): Promise<void> {
    throw new Error("Method not implemented.");
  }
  findById(id: import("mongoose").Types.ObjectId): Promise<Game | null> {
    throw new Error("Method not implemented.");
  }
  findByName(name: string): Promise<Game[] | null> {
    throw new Error("Method not implemented.");
  }
  findAll(): Promise<Game[]> {
    throw new Error("Method not implemented.");
  }
}
