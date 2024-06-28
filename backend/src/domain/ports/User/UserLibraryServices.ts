import { IUserGame } from "../../entities/User";
import { IUserRepositoryGame } from "./UserRepository";

export interface ILibrary {
  favorites: IUserRepositoryGame[];
  notFavorites: IUserRepositoryGame[];
}

export interface IUserLibraryServices {
  getUserLibrary(userId: string): Promise<ILibrary>;
  getUserGames(userId: string): Promise<IUserRepositoryGame[]>;
  searchUsersLibrary(userId: string, gameTitle: string): Promise<IUserGame[]>;
  setGameFavorite(userId: string, gameId: string): Promise<void>;
}
