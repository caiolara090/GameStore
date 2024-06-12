import app from './App';
import 'dotenv/config';
import { connectToDatabase } from './config/db.config';

const port = process.env.PORT;

connectToDatabase().then(() => {
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });
});