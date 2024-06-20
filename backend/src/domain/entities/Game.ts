export interface IGame {
  name: string;
  description: string;
  price: number;
  image: string;
  reviews?: string[];
  rating?: number;
  _id?: string;
}
