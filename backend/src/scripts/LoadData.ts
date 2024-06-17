import 'dotenv/config';
import { GameModel } from '../adapters/database/models';
import mongoose from 'mongoose';

const loadData = async () => {
  await mongoose.connect(process.env.MONGODB_URI as string, {dbName: 'gamestore'});

  if (mongoose.connection.readyState !== 1) {
    console.error('Failed to connect to MongoDB with Mongoose');
    process.exit(1);
  }

  const apiurl = "https://api.mobygames.com/v1/games";
  const apiKey = process.env.API_KEY;
  
  let games: any = [];

  for (let i = 0; i < 10; i++) {
    console.log(`Loading page ${i + 1}`);
    await new Promise(resolve => setTimeout(resolve, 1000));
    const res = await fetch(`${apiurl}?api_key=${apiKey}&offset=${i * 100}`);
    const data = await res.json();
    games = [...games, ...data.games];
  }

  games = games.map((game: any) => 
    ({ 
      name: game.title, 
      description: game.description,
      image: game.sample_cover?.image ?? null,
      price: Math.floor(Math.random() * 250) + 1
    })
  );

  games = games.filter((game: any) => game.image !== null).filter((game: any) => game.description !== null);

  console.log(games);


  console.log(`Loading ${games.length} games to the database...`);
  GameModel.insertMany(games);
  console.log('Games loaded successfully');
  process.exit(0);
}

loadData();