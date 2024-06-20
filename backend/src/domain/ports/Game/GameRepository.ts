import { IGame } from "../../entities/Game";
import { IReview } from "../../entities/Review";

export interface IGameRepository {
  create(game: IGame): Promise<IGame>;
  update(_id: string, game: Partial<IGame>): Promise<IGame>;
  delete(_id: string): Promise<void>;
  find(game: Partial<IGame>): Promise<IGame | IGame[] | null>;
  findById(_id: string): Promise<IGame | null>;
  searchGames(gameTitle: string, fields: string): Promise<IGame[] | null>;
  getPopularGames(): Promise<IGame[] | null>;
  insertReview(gameId: string, review: IReview): Promise<void>;
  removeReview(gameId: string, review: IReview): Promise<void>;
}
