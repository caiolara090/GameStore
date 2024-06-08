import { Types } from 'mongoose';

export interface IReview {
  title: string;
  description: string;
  rating: number;
  user: string;
  game: string;
  _id?: string;
}

export class Review implements IReview {
  constructor(
    public title: string,
    public description: string,
    public rating: number,
    public user: string,
    public game: string,
    public _id?: string,
  ) {}
}
