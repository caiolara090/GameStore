import express from 'express';
import CookieParser from 'cookie-parser';
import { userRouter } from './adapters/api/routes/User';
import { friendshipRouter } from './adapters/api/routes/Friendship';

const app = express();

app
  .use(express.json())
  .use(CookieParser())
  .use(userRouter)
  .use(friendshipRouter);

export default app;
