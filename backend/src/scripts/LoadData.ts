import 'dotenv/config';
import { GameModel } from '../adapters/database/models';
import mongoose from 'mongoose';
import { htmlToText } from 'html-to-text';

const loadData = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI as string, {dbName: 'gamestore'});
    console.log('Connected to MongoDB successfully');

    const apiurl = "https://api.mobygames.com/v1/games";
    const apiKey = process.env.API_KEY;
    
    let games: any = [];

    for (let i = 0; i < 1; i++) {
      console.log(`Loading page ${i + 1}`);
      await new Promise(resolve => setTimeout(resolve, 1000));
      const res = await fetch(`${apiurl}?api_key=${apiKey}&offset=${i * 100}`);
      const data = await res.json();
      games = [...games, ...data.games];
    }

    games = games.map((game: any) => 
      ({ 
        name: game.title, 
        description: htmlToText(game.description, { wordwrap: null }),
        image: game.sample_cover?.image ?? null,
        price: Math.floor(Math.random() * 250) + 1
      })
    );

    games = games.filter((game: any) => game.image !== null).filter((game: any) => game.description !== null);

    console.log(`Loading ${games.length} games to the database...`);
    // console.log(games);
    await GameModel.insertMany(games); // Use await aqui
    console.log('Games loaded successfully');
  } catch (error) {
    console.error('An error occurred:', error);
  } finally {
    await mongoose.disconnect(); // Feche a conexão de maneira adequada
    console.log('Disconnected from MongoDB');
  }
}

loadData();