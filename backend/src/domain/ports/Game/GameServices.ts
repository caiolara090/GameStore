import { IGame } from "../../entities/Game";

export interface IGameServices {
  searchGames(gameTitle: string, fields: string): Promise<IGame[] | null>;
}
