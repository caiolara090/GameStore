import { initializeDatabase } from "../dbHandler";
import httpMocks from "node-mocks-http";
import { UserModel } from "../../src/adapters/database/models/User";
import { GameModel } from "../../src/adapters/database/models/Game";
import {
  buyGame,
  addCredits,
  hasGame,
} from "../../src/adapters/api/controllers/user/UserStore";
import { IGame } from "../../src/domain/entities/Game";
import bcrypt from "bcryptjs";
import { isMainThread } from "worker_threads";

describe("User Store", () => {
  let db: any;
  let user: any;
  let games: IGame[] = [
    {
      name: "game1",
      description: "description",
      image: "image",
      price: 10,
    },
    {
      name: "game2",
      description: "description",
      image: "image",
      price: 40,
    },
  ];

  beforeAll(async () => {
    db = await initializeDatabase();
    await db.connect();
  });

  beforeEach(async () => {
    await db.clearDatabase();

    user = await UserModel.create({
      username: "test",
      age: 20,
      email: "test@test.com",
      password: bcrypt.hashSync("123456"),
    });

    games = await GameModel.insertMany(games);
  });

  afterAll(async () => {
    await db.closeDatabase();
  });

  it("should not buy a game if the user doesn't have enough credits", async () => {
    const req = httpMocks.createRequest({
      body: {
        userId: user._id,
        gameId: games[0]._id,
      },
    });
    const res = httpMocks.createResponse();

    await buyGame(req, res);

    const updatedUser = await UserModel.findById(user._id);

    expect(res.statusCode).toBe(400);

    expect(updatedUser && 
      updatedUser.games && 
      updatedUser.games.length).toBe(0);
  });

  it("should buy a game successfully", async () => {
    user.credits = 100;
    await user.save();

    const req = httpMocks.createRequest({
      body: {
        userId: user._id,
        gameId: games[0]._id,
      },
    });
    const res = httpMocks.createResponse();

    await UserModel.findByIdAndUpdate(user._id, { credits: 100 });

    await buyGame(req, res);

    await UserModel.ensureIndexes();

    // sleeps for 1 second to wait for the database to update
    await new Promise((resolve) => setTimeout(resolve, 1000));

    const updatedUser = await UserModel.findById(user._id);

    expect(res.statusCode).toBe(201);

    expect(updatedUser && 
      updatedUser.games && 
      updatedUser.games.length).toBe(1);

    expect(updatedUser &&
      updatedUser.credits).toBe(90);

    expect(updatedUser &&
      updatedUser.games &&
      updatedUser.games[0] &&
      updatedUser.games[0].game.toString()).toBe(
        games && 
        games[0] &&
        games[0]._id && 
        games[0]._id.toString()
      );
  });

  it('should add credits successfully', async () => {
    const req = httpMocks.createRequest({
      body: {
        userId: user._id,
        credits: 100
      }
    });

    const res = httpMocks.createResponse();

    await addCredits(req, res);

    const updatedUser = await UserModel.findById(user._id);

    expect(res.statusCode).toBe(200);

    expect(updatedUser && 
      updatedUser.credits).toBe(100);
  });

  it('should check if user has a game successfully', async () => {
    await UserModel.findByIdAndUpdate(user._id, {$push: {games: {game: games[0]._id, favorites: false}}});
    await user.save();

    await UserModel.ensureIndexes();

    const req = httpMocks.createRequest({
      query: {
        userId: user._id,
        gameId: games[0]._id!.toString()
      }
    });

    const res = httpMocks.createResponse();

    await hasGame(req, res);

    expect(res.statusCode).toBe(200);

    expect(res._getJSONData().hasGame).toBe(true);
  });
});
