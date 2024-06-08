import { Types } from 'mongoose';

export interface IReview {
  title: string;
  description: string;
  rating: number;
  user: Types.ObjectId;
  game: Types.ObjectId;
  id?: Types.ObjectId;
}

export class Review implements IReview {
  constructor(
    public title: string,
    public description: string,
    public rating: number,
    public user: Types.ObjectId,
    public game: Types.ObjectId,
    public id?: Types.ObjectId,
  ) {}
}
