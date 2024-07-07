import { initializeDatabase } from "../dbHandler";
import httpMocks from "node-mocks-http";
import { GameModel } from "../../src/adapters/database/models/Game";
import { ReviewModel } from "../../src/adapters/database/models/Review";
import {
  searchGames,
  getPopularGames,
} from "../../src/adapters/api/controllers/game/Game";
import { IGame } from "../../src/domain/entities/Game";

describe("Game", () => {
  let db: any;
  let game1: any;
  let game2: any;
  let game3: any;

  beforeAll(async () => {
    db = await initializeDatabase();
    await db.connect();
  });

  beforeEach(async () => {
    await db.clearDatabase();

    game1 = await GameModel.create({
      name: "game1",
      description: "description1",
      price: 10,
      image: "image",
    });

    game2 = await GameModel.create({
      name: "game2",
      description: "description2",
      price: 20,
      image: "image",
    });

    game3 = await GameModel.create({
      name: "game3",
      description: "description3",
      price: 30,
      image: "image",
    });
  });

  afterAll(async () => {
    await db.closeDatabase();
  });

  it("should search games by name", async () => {
    const req = httpMocks.createRequest({
      body: {
        gameTitle: "game1",
        fields: ["name", "description", "price", "image"],
      },
    });

    // Para interpretar a model de review antes do teste
    ReviewModel.ensureIndexes(); 

    const res = httpMocks.createResponse();

    await searchGames(req, res);

    const data = JSON.parse(res._getData());

    expect(res.statusCode).toBe(200);
    expect(data.games).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          name: "game1",
          description: "description1",
          price: 10,
        }),
      ])
    );
  });

  it("should get popular games", async () => {
    const req = httpMocks.createRequest();
    const res = httpMocks.createResponse();

    await getPopularGames(req, res);

    const data = JSON.parse(res._getData());

    expect(res.statusCode).toBe(200);
    expect(data.games).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          name: "game1",
          description: "description1",
          price: 10,
        }),
        expect.objectContaining({
          name: "game2",
          description: "description2",
          price: 20,
        }),
        expect.objectContaining({
          name: "game3",
          description: "description3",
          price: 30,
        }),
      ])
    );
  });
});