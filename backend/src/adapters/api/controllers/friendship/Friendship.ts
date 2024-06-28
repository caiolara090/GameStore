import "http-status-codes";
import { IFriendshipRequest } from "../../../../domain/entities/Friendship";
import { Request, Response } from "express";
import { IFriendshipServices } from "../../../../domain/ports/Friendship/FriendshipServices";
import { FriendshipServices } from "../../../../domain/services/FriendshipServices";

export const createFriendshipRequest = async (
  req: Request<{}, {}, IFriendshipRequest>,res: Response) => {
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
  const userId = req.query.userId as string;
  const friendId = req.query.friendId as string;
  if (!userId || !friendId) {
    res.status(400).send("Error deleting friendship: userId and friendId are required");
    return;
  }
  try {
    await friendshipServices.delete(userId, friendId);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send("Error deleting friendship: " + error.message);
  }
};

export const getFriendshipRequests = async (
  req: Request,
  res: Response
) => {
  const friendshipServices: IFriendshipServices = new FriendshipServices();
  const userId = req.query.userId as string;
  if (!userId) {
    res.status(400).send("Error getting friendship requests: userId is required");
    return;
  }
  try {
    const friendshipRequests = await friendshipServices.find({ userId, status: 1 });
    res.status(200).send(friendshipRequests);
  } catch (error: any) {
    res.status(400).send("Error getting friendship requests: " + error.message);
  }
};

export const getFriends = async (
  req: Request,
  res: Response
) => {
  const friendshipServices: IFriendshipServices = new FriendshipServices();
  const userId = req.query.userId as string;
  if (!userId) {
    res.status(400).send("Error getting friends: userId is required");
    return;
  }
  try {
    const friends = await friendshipServices.find({ userId, status: 2 });
    res.status(200).send(friends);
  } catch (error: any) {
    res.status(400).send("Error getting friends: " + error.message);
  }
};
