import express from 'express';
import CookieParser from 'cookie-parser';
import { userRouter } from './adapters/api/routes/User';

const app = express();

app
  .use(express.json())
  .use(CookieParser())
  .use(userRouter)

export default app;
