import { Router } from "express";
import {
  createFriendshipRequest,
  acceptFriendshipRequest,
  rejectFriendshipRequest,
  deleteFriendship,
} from "../controllers/friendship/Friendship";

const router = Router();

router.post("/createFriendshipRequest", createFriendshipRequest);

router.post("/acceptFriendshipRequest", acceptFriendshipRequest);

router.post("/rejectFriendshipRequest", rejectFriendshipRequest);

router.delete("/deleteFriendship", deleteFriendship);

export { router as friendshipRouter };
