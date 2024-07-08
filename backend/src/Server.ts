import app from './app';
import 'dotenv/config';
import { connectToDatabase } from './config/db.config';

const port = process.env.PORT;
const env = process.env.NODE_ENV as string;

connectToDatabase(env).then(() => {
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });
});