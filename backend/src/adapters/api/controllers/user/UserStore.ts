import { UserStoreServices } from "../../../../domain/services/UserStoreServices";
import { Request, Response } from "express";
import { IUserStoreServices } from "../../../../domain/ports/User/UserStoreServices";
import { IUserServices } from "../../../../domain/ports/User/UserServices";
import { UserServices } from "../../../../domain/services/UserServices";
import { StatusCodes } from "http-status-codes";

export const buyGame = async (req: Request, res: Response) => {
  const userStoreServices: IUserStoreServices = new UserStoreServices();

  const { userId, gameId } = req.body;
  try {
    await userStoreServices.buyGame(userId, gameId);
    res.status(StatusCodes.CREATED).send();
  } catch (error: any) {
    res.status(StatusCodes.BAD_REQUEST).send("Error buying game: " + error.message);
  }
}

export const addCredits = async (req: Request, res: Response) => {
  const userStoreServices: IUserStoreServices = new UserStoreServices();

  const { userId, credits } = req.body;
  try {
    await userStoreServices.addCredits(userId, credits);
    res.status(StatusCodes.OK).send();
  } catch (error: any) {
    res.status(StatusCodes.BAD_REQUEST).send("Error adding credits: " + error.message);
  }
}

export const hasGame = async (req: Request, res: Response) => {
  const userServices: IUserServices = new UserServices();

  const { userId, gameId } = req.query;
  try {
    const user = await userServices.findById(userId as string);
    for (const game of user!.games!) {
      console.log(game.game._id?.toString(), gameId);
      if (game.game._id?.toString() === gameId) {
        res.status(200).json({ hasGame: true });
        return;
      }
    }
    res.status(200).json({ hasGame: false });
  } catch (error: any) {
    res.status(400).send("Error checking if user has game: " + error.message);
  }
}
