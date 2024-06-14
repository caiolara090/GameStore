import { GameSearchResult } from "../../entities/Game";

export interface IGameServices {
  searchGames(
    gameTitle: string,
    fields: string,
    sortField: string,
    page: Number,
    limit: Number
  ): Promise<GameSearchResult | null>;
}
