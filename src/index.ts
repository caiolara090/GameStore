import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3000;

// Middleware para parsear JSON
app.use(express.json());

// Rota principal
app.get('/', (req: Request, res: Response) => {
  res.send('Hello, world!');
});

// Iniciar o servidor
app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
