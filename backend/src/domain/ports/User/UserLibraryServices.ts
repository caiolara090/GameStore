import { IUserRepositoryGame } from "./UserRepository";

export interface ILibrary {
  favorites: IUserRepositoryGame[];
  notFavorites: IUserRepositoryGame[];
}

export interface IUserLibraryServices {
  getUserLibrary(userId: string): Promise<ILibrary>;
  getUserGames(userId: string): Promise<IUserRepositoryGame[]>;
}
