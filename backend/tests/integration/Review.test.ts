import { initializeDatabase } from "../dbHandler";
import httpMocks from "node-mocks-http";
import { ReviewModel } from "../../src/adapters/database/models/Review";
import { UserModel } from "../../src/adapters/database/models/User";
import { GameModel } from "../../src/adapters/database/models/Game";
import {
  createReview,
  findReview,
  deleteReview,
} from "../../src/adapters/api/controllers/review/Review";
import bcrypt from "bcryptjs";

describe("Review", () => {
  let db: any;
  let user: any;
  let games: any = [
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

  it("should create a review", async () => {
    const review = {
      userId: user._id,
      gameId: games[0]._id,
      rating: 5,
      description: "Great game",
    };

    const req = httpMocks.createRequest({
      body: review,
    });

    const res = httpMocks.createResponse();

    await createReview(req, res);

    expect(res.statusCode).toBe(201);
    expect(await ReviewModel.find()).toHaveLength(1);
    expect((await ReviewModel.findOne())!.rating).toBe(5);
    expect((await ReviewModel.findOne())!.description).toBe("Great game");
  });

  it("should find a review", async () => {
    const review = await ReviewModel.create({
      userId: user._id,
      gameId: games[0]._id,
      rating: 5,
      description: "Great game",
    });

    const req = httpMocks.createRequest({
      query: {
        userId: user._id,
      },
    });

    const res = httpMocks.createResponse();

    await findReview(req, res);

    expect(res.statusCode).toBe(200);
    expect(res._getData().rating).toBe(5);
    expect(res._getData().description).toBe("Great game");
  });

  it("should delete a review", async () => {
    const review = await ReviewModel.create({
      userId: user._id,
      gameId: games[0]._id,
      rating: 5,
      description: "Great game",
    });

    const req = httpMocks.createRequest({
      query: {
        reviewId: review._id,
      },
    });

    const res = httpMocks.createResponse();

    await deleteReview(req, res);

    expect(res.statusCode).toBe(200);
    expect(await ReviewModel.find()).toHaveLength(0);
  });
});