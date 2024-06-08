import { Types } from 'mongoose';

export interface IGame {
  name: string;
  description: string;
  image: string;
  price: number;
  id?: Types.ObjectId;
  reviews?: Types.ObjectId[];
}

export class Game implements IGame {
  constructor(
    public name: string,
    public description: string,
    public image: string,
    public price: number,
    public id?: Types.ObjectId,
    public reviews?: Types.ObjectId[],
  ) {}
}
