import { Game } from '../../entities/Game';
import { Types } from 'mongoose';

export interface IGameRepository {
  create(game: Game): Promise<Game>;
  update(game: Game): Promise<Game>;
  delete(id: Types.ObjectId): Promise<void>;
  findById(id: Types.ObjectId): Promise<Game | null>;
  findByName(name: string): Promise<Game[] | null>;
  findAll(): Promise<Game[]>;
}
