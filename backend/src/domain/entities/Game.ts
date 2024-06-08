import { Types } from 'mongoose';

export interface IGame {
  name: string;
  description: string;
  price: number;
  image: string;
  reviews?: string[];
  _id?: string;
}

export class Game implements IGame {
  constructor(
    public name: string,
    public description: string,
    public price: number,
    public image: string,
    public reviews?: string[],
    public _id?: string,
  ) {}
}
