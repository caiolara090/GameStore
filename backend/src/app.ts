import express from "express";
import CookieParser from "cookie-parser";
import { userRouter } from "./adapters/api/routes/User";
import { gameRouter } from "./adapters/api/routes/Games";
import { friendshipRouter } from './adapters/api/routes/Friendship';

const app = express();

app
  .use(express.json())
  .use(CookieParser())
  .use(userRouter)
  .use(friendshipRouter)
  .use(gameRouter)

export default app;
