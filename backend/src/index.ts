import { server } from './Server';
import 'dotenv/config';
import { connectToDatabase } from './config/DatabaseConnection';

// Try to connect to the database
connectToDatabase();

const port = process.env.PORT;

server.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
