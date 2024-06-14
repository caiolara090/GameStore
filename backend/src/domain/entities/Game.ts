export interface IGame {
  name: string;
  description: string;
  price: number;
  image: string;
  reviews?: string[];
  favorite: boolean;
}

export class Game implements IGame {
  constructor(
    public name: string,
    public description: string,
    public price: number,
    public image: string,
    public favorite: boolean,
    public reviews?: string[]
  ) {}
}
