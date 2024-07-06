import { initializeDatabase } from "../dbHandler";
import httpMocks from "node-mocks-http";
import bcrypt from "bcryptjs";
import { UserModel } from "../../src/adapters/database/models/User";
import { GameModel } from "../../src/adapters/database/models/Game";
import {
  getUserLibrary,
  getUserGames,
  setGameFavorite,
  searchUsersLibrary,
} from "../../src/adapters/api/controllers/user/UserLibrary";
import { IGame } from "../../src/domain/entities/Game";

describe("User Library", () => {
  let db: any;
  let user: any;
  let games: IGame[] = [
    {
      name: "game1",
      description: "description",
      image: "image",
      price: 10
    },
    {
      name: "game2",
      description: "description",
      image: "image",
      price: 40
    }
  ]

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

    games.map(game => {
      if (!user.games) {
        user.games = [];
      }
      user.games.push({
        game: game._id,
        favorite: false
      });
    });

    await user.save();
  });

  afterAll(async () => {
    await db.closeDatabase();
  });

  it("should get user library successfully", async () => {
    const httpRequest = httpMocks.createRequest({
      method: "GET",
      url: "/library",
      query: {
        userId: user._id,
      }
    });

    const httpResponse = httpMocks.createResponse();

    await getUserLibrary(httpRequest, httpResponse);

    expect(httpResponse.statusCode).toBe(200);
    expect(httpResponse._getJSONData().notFavorites).toHaveLength(2);
    expect(httpResponse._getJSONData().favorites).toHaveLength(0);
    expect(httpResponse._getJSONData().notFavorites[0].game.name).toBe("game1");
    expect(httpResponse._getJSONData().notFavorites[1].game.name).toBe("game2");
  });

  it("should get user games successfully", async () => {
    const httpRequest = httpMocks.createRequest({
      method: "GET",
      url: "/games",
      query: {
        userId: user._id,
      }
    });

    const httpResponse = httpMocks.createResponse();

    await getUserGames(httpRequest, httpResponse);

    expect(httpResponse.statusCode).toBe(200);
    expect(httpResponse._getJSONData()).toHaveLength(2);
    expect(httpResponse._getJSONData()[0].game.name).toBe("game1");
    expect(httpResponse._getJSONData()[1].game.name).toBe("game2");
  });

  it("should set game as favorite successfully", async () => {
    const httpRequest = httpMocks.createRequest({
      method: "POST",
      url: "/setFavorite",
      body: {
        userId: user._id,
        gameId: user.games[0].game._id
      }
    });

    const httpResponse = httpMocks.createResponse();

    await setGameFavorite(httpRequest, httpResponse);

    // Todo fazer isso aqui funcionar. 
    // O id não tá pegando certo ou alguma coisa assim
    // Talvez valha a pena ignorar
    expect(httpResponse.statusCode).toBe(200);
    
    const updatedUser = await UserModel.findById(user._id);

    if (!updatedUser) throw new Error("User not found");

    expect(updatedUser?.games?.[0]?.favorite).toBe(true);
  });

  it("should search users library successfully", async () => {
    const httpRequest = httpMocks.createRequest({
      method: "GET",
      url: "/searchUserLibrary",
      body: {
        userId: user._id,
        gameTitle: "game1"
      }
    });

    const httpResponse = httpMocks.createResponse();

    await searchUsersLibrary(httpRequest, httpResponse);

    expect(httpResponse.statusCode).toBe(200);
    expect(httpResponse._getJSONData().library).toHaveLength(1);
    expect(httpResponse._getJSONData().library[0].game.name).toBe("game1");
  });
});
