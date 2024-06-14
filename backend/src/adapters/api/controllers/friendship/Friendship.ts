import "http-status-codes";
import { IFriendshipRequest } from "../../../../domain/entities/Friendship";
import { Request, Response } from "express";
import { IFriendshipServices } from "../../../../domain/ports/Friendship/FriendshipServices";
import { FriendshipServices } from "../../../../domain/services/FriendshipServices";

// todo revisar, decidir se vai fazer tudo com dois id
export const createFriendshipRequest = async (
  req: Request<{}, {}, IFriendshipRequest>,
  res: Response
) => {
  const friendshipServices: IFriendshipServices = new FriendshipServices();
  const { userId, friendId }: IFriendshipRequest = req.body;
  try {
    await friendshipServices.createFriendshipRequest(userId, friendId);
    res.status(201).send();
  } catch (error: any) {
    res.status(400).send("Error creating friendship: " + error.message);
  }
};

export const acceptFriendshipRequest = async (
  req: Request<{}, {}, IFriendshipRequest>,
  res: Response
) => {
  const friendshipServices: IFriendshipServices = new FriendshipServices();
  const { userId, friendId }: IFriendshipRequest = req.body;
  try {
    await friendshipServices.acceptFriendshipRequest(userId, friendId);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send("Error accepting friendship: " + error.message);
  }
};

export const rejectFriendshipRequest = async (
  req: Request<{}, {}, IFriendshipRequest>,
  res: Response
) => {
  const friendshipServices: IFriendshipServices = new FriendshipServices();
  const { userId, friendId }: IFriendshipRequest = req.body;
  try {
    await friendshipServices.rejectFriendshipRequest(userId, friendId);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send("Error rejecting friendship: " + error.message);
  }
};

export const deleteFriendship = async (
  req: Request<{}, {}, IFriendshipRequest>,
  res: Response
) => {
  const friendshipServices: IFriendshipServices = new FriendshipServices();
  const { userId, friendId }: IFriendshipRequest = req.body;
  try {
    await friendshipServices.delete(userId, friendId);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send("Error deleting friendship: " + error.message);
  }
};
