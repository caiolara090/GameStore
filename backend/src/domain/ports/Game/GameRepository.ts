import { IGame } from '../../entities/Game';

export interface IGameRepository {
  create(game: IGame): Promise<IGame>;
  update(_id: string, game: Partial<IGame>): Promise<IGame>;
  delete(_id: string): Promise<void>;
  find(game: Partial<IGame>): Promise<IGame | IGame[] | null>;
  findById(_id: string): Promise<IGame | null>;
}
