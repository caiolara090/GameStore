import express from "express";
import CookieParser from "cookie-parser";
import { userRouter } from "./adapters/api/routes/User";
import { gameRouter } from "./adapters/api/routes/Games";

const app = express();

app.use(express.json()).use(CookieParser()).use(userRouter).use(gameRouter);

export default app;
