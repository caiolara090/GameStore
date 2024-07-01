import { Router } from "express";
import {
  createFriendshipRequest,
  acceptFriendshipRequest,
  rejectFriendshipRequest,
  deleteFriendship,
  getFriendshipRequests,
  getFriends,
} from "../controllers/friendship/Friendship";
import { checkJwtToken } from "../middlewares/Auth/CheckToken";

const router = Router();

router.post("/createFriendshipRequest", checkJwtToken, createFriendshipRequest);

router.post("/acceptFriendshipRequest", checkJwtToken, acceptFriendshipRequest);

router.post("/rejectFriendshipRequest", checkJwtToken, rejectFriendshipRequest);

router.delete("/deleteFriendship", checkJwtToken, deleteFriendship);

router.get("/friendshipRequests", checkJwtToken, getFriendshipRequests);

router.get("/friends", checkJwtToken, getFriends);

export { router as friendshipRouter };
