import { IGame } from "./Game";

export interface IUser {
  userId?: string;
  username: string;
  age: number;
  email: string;
  password: string;
  games?: IGame[];
}

export interface SignUpRequest {
  username: string;
  age: number;
  email: string;
  password: string;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface UserSearchResult {
  users: Partial<IUser>[];
  resPage: {
    currentPage: number;
    totalPages: number;
    size: number;
  };
}
