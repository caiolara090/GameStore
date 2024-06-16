import { UserStoreServices } from "../../../../domain/services/UserStoreServices";
import { Request, Response } from "express";
import { IUserStoreServices } from "../../../../domain/ports/User/UserStoreServices";

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