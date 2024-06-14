import { IGame } from "../../entities/Game";

export interface IGameServices {
  getLibraryGames(userId: string): Promise<Partial<IGame>[] | null>;
}
