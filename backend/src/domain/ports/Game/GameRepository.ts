import { GameSearchResult, IGame } from "../../entities/Game";

export interface IGameRepository {
  create(game: IGame): Promise<IGame>;
  update(_id: string, game: Partial<IGame>): Promise<IGame>;
  delete(_id: string): Promise<void>;
  find(game: Partial<IGame>): Promise<IGame | IGame[] | null>;
  searchGames(
    gameTitle: string,
    fields: string,
    sortField: string,
    page: number,
    limit: number
  ): Promise<GameSearchResult | null>;
}
