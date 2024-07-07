import { initializeDatabase } from "../dbHandler";
import httpMocks from "node-mocks-http";
import { UserModel } from "../../src/adapters/database/models/User";
import { FriendshipModel } from "../../src/adapters/database/models/Friendship";
import {
  createFriendshipRequest,
  acceptFriendshipRequest,
  rejectFriendshipRequest,
  deleteFriendship,
  getFriendshipRequests,
  getFriends,
} from "../../src/adapters/api/controllers/friendship/Friendship";
import { IFriendshipRequest } from "../../src/domain/entities/Friendship";
import bcrypt from "bcryptjs";

describe("Friendship", () => {
  let db: any;
  let user1: any;
  let user2: any;
  let user3: any;

  beforeAll(async () => {
    db = await initializeDatabase();
    await db.connect();
  });

  beforeEach(async () => {
    await db.clearDatabase();

    user1 = await UserModel.create({
      username: "test1",
      age: 20,
      email: "test1@test.com",
      password: bcrypt.hashSync("123456"),
    });

    user2 = await UserModel.create({
      username: "test2",
      age: 20,
      email: "test2@test.com",
      password: bcrypt.hashSync("123456"),
    });

    user3 = await UserModel.create({
      username: "test3",
      age: 20,
      email: "test3@test.com",
      password: bcrypt.hashSync("123456"),
    });
  });

  afterAll(async () => {
    await db.closeDatabase();
  });

  it("should create a friendship request", async () => {
    const req = httpMocks.createRequest({
      body: {
        userId: user1._id,
        friendId: user2._id,
      },
    });
    const res = httpMocks.createResponse();

    await createFriendshipRequest(req, res);

    const friendship = await FriendshipModel.findOne({
      userId: user1._id,
      friendId: user2._id,
    });

    expect(res.statusCode).toBe(201);
    expect(friendship).not.toBeNull();
  });

  it("should accept a friendship request", async () => {
    await FriendshipModel.create({
      userId: user1._id,
      friendId: user2._id,
      status: 1,
    });

    await FriendshipModel.create({
      userId: user2._id,
      friendId: user1._id,
      status: 0,
    });

    const req = httpMocks.createRequest({
      body: {
        userId: user1._id,
        friendId: user2._id,
      },
    });
    const res = httpMocks.createResponse();

    await acceptFriendshipRequest(req, res);

    const friendship = await FriendshipModel.findOne({
      userId: user1._id,
      friendId: user2._id,
    });

    expect(res.statusCode).toBe(200);
    expect(friendship?.status).toBe(2);
  });

  it("should reject a friendship request", async () => {
    await FriendshipModel.create({
      userId: user1._id,
      friendId: user2._id,
      status: 1,
    });

    await FriendshipModel.create({
      userId: user2._id,
      friendId: user1._id,
      status: 0,
    });

    const req = httpMocks.createRequest({
      body: {
        userId: user1._id,
        friendId: user2._id,
      },
    });
    const res = httpMocks.createResponse();

    await rejectFriendshipRequest(req, res);

    const friendship = await FriendshipModel.findOne({
      userId: user1._id,
      friendId: user2._id,
    });

    expect(res.statusCode).toBe(200);
    expect(friendship).toBeNull();
  });

  it("should delete a friendship", async () => {
    await FriendshipModel.create({
      userId: user1._id,
      friendId: user2._id,
      status: 2,
    });

    await FriendshipModel.create({
      userId: user2._id,
      friendId: user1._id,
      status: 2,
    });

    const req = httpMocks.createRequest({
      query: {
        userId: user1._id,
        friendId: user2._id,
      },
    });
    const res = httpMocks.createResponse();

    await deleteFriendship(req, res);

    const friendship = await FriendshipModel.findOne({
      userId: user1._id,
      friendId: user2._id,
    });

    expect(res.statusCode).toBe(200);
    expect(friendship).toBeNull();
  });

  it("should get friendship requests", async () => {
    await FriendshipModel.create({
      userId: user1._id,
      friendId: user2._id,
      status: 1,
    });

    await FriendshipModel.create({
      userId: user2._id,
      friendId: user1._id,
      status: 0,
    });

    await FriendshipModel.create({
      userId: user1._id,
      friendId: user3._id,
      status: 1,
    });

    await FriendshipModel.create({
      userId: user3._id,
      friendId: user1._id,
      status: 0,
    });

    const req = httpMocks.createRequest({
      query: {
        userId: user1._id,
      },
    });
    const res = httpMocks.createResponse();

    await getFriendshipRequests(req, res);

    const friendshipRequests = res._getData();

    expect(res.statusCode).toBe(200);
    expect(friendshipRequests).toHaveLength(2);
    expect(friendshipRequests[0].userId._id.toString()).toBe(user1._id.toString());
    expect(friendshipRequests[0].friendId._id.toString()).toBe(user2._id.toString());
  });

  it("should get friends", async () => {
    await FriendshipModel.create({
      userId: user1._id,
      friendId: user2._id,
      status: 2,
    });

    await FriendshipModel.create({
      userId: user2._id,
      friendId: user1._id,
      status: 2,
    });

    await FriendshipModel.create({
      userId: user1._id,
      friendId: user3._id,
      status: 2,
    });

    await FriendshipModel.create({
      userId: user3._id,
      friendId: user1._id,
      status: 2,
    });

    const req = httpMocks.createRequest({
      query: {
        userId: user1._id,
      },
    });
    const res = httpMocks.createResponse();

    await getFriends(req, res);

    const friends = res._getData();

    expect(res.statusCode).toBe(200);
    expect(friends).toHaveLength(2);
    expect(friends[0].friendId._id.toString()).toBe(user2._id.toString());
    expect(friends[0].userId._id.toString()).toBe(user1._id.toString());
  });
});