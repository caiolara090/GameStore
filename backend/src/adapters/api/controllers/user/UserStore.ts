import { UserStoreServices } from "../../../../domain/services/UserStoreServices";
import { Request, Response } from "express";
import { IUserLibraryServices } from "../../../../domain/ports/User/UserLibraryServices";
import { UserLibraryServices } from "../../../../domain/services/UserLibraryServices";
import { IUserStoreServices } from "../../../../domain/ports/User/UserStoreServices";
import { IUserServices } from "../../../../domain/ports/User";
import { UserServices } from "../../../../domain/services/UserServices";

export const buyGame = async (req: Request, res: Response) => {
  const userStoreServices: IUserStoreServices = new UserStoreServices();

  const { userId, gameId } = req.body;
  try {
    await userStoreServices.buyGame(userId, gameId);
    res.status(201).send();
  } catch (error: any) {
    res.status(400).send("Error buying game: " + error.message);
  }
}

export const addCredits = async (req: Request, res: Response) => {
  const userStoreServices: IUserStoreServices = new UserStoreServices();

  const { userId, credits } = req.body;
  try {
    await userStoreServices.addCredits(userId, credits);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send("Error adding credits: " + error.message);
  }
}

export const hasGame = async (req: Request, res: Response) => {
  const userServices: IUserServices = new UserServices();

  const { userId, gameId } = req.query;
  try {
    const user = await userServices.findById(userId as string);
    for (const game of user!.games!) {
      if (game.game._id === gameId) {
        res.status(200).json({ hasGame: true });
        return;
      }
    }
    res.status(200).json({ hasGame: false });
  } catch (error: any) {
    res.status(400).send("Error checking if user has game: " + error.message);
  }
}
