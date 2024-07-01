import { IUser, IUserGame } from "../../entities/User";

export interface IUserRepositoryGame {
  name: string;
  image: string;
  favorite: boolean;
}

export interface IUserRepository {
  create(user: IUser): Promise<IUser>;
  find(user: Partial<IUser>): Promise<IUser | IUser[] | null>;
  findByEmail(email: string): Promise<IUser | null>;
  findByUsername(username: string): Promise<IUser | null>;
  findById(_id: string): Promise<IUser | null>;
  addCredits(_id: string, credits: number): Promise<void>;
  addGame(_id: string, game: string): Promise<void>;
  getGames(_id: string): Promise<IUserRepositoryGame[]>;
  retrieveUserLibrary(userId: string): Promise<IUserGame[]>
  update(user: IUser): Promise<void>;
};
