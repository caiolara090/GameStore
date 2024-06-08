import { Game } from '../../entities/Game';

export interface IGameRepository {
  create(game: Game): Promise<Game>;
  update(_id: string, game: Partial<Game>): Promise<Game>;
  delete(_id: string): Promise<void>;
  find(game: Partial<Game>): Promise<Game | Game[] | null>;
}
