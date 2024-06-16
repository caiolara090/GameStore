import { Router } from 'express';
import { 
  createFriendshipRequest, 
  acceptFriendshipRequest, 
  rejectFriendshipRequest,
  deleteFriendship
} from '../controllers/Friendship';
import { checkJwtToken } from '../middlewares/Auth/CheckJWTToken';

const router = Router();

router.post('/createFriendshipRequest', checkJwtToken, createFriendshipRequest);

router.post('/acceptFriendshipRequest', checkJwtToken, acceptFriendshipRequest);

router.post('/rejectFriendshipRequest', checkJwtToken, rejectFriendshipRequest);

router.delete('/deleteFriendship', checkJwtToken, deleteFriendship);

export { router as friendshipRouter };