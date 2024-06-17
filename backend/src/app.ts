import express from "express";
import CookieParser from "cookie-parser";
import { userRouter } from "./adapters/api/routes/User";
import { gameRouter } from "./adapters/api/routes/Games";
import { friendshipRouter } from './adapters/api/routes/Friendship';
import { reviewRouter } from "./adapters/api/routes/Review";

const app = express();

app
  .use(express.json())
  .use(CookieParser())
  .use(userRouter)
  .use(friendshipRouter)
  .use(gameRouter)
  .use(reviewRouter);

export default app;
