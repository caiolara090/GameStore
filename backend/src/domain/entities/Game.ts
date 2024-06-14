export interface IGame {
  name: string;
  description: string;
  price: number;
  image: string;
  reviews?: string[];
  favorite: boolean;
}

export interface GameSearchResult {
  games: Partial<IGame>[];
  resPage: {
    currentPage: number;
    totalPages: number;
    size: number;
  };
}
