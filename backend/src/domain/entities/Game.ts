export interface IGame {
  gameId?: string;
  name: string;
  description: string;
  price: number;
  image: string;
  reviews?: string[];
}
