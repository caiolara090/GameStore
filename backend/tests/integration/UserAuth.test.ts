import { initializeDatabase } from "../dbHandler";
import httpMocks from "node-mocks-http";
import { signUp } from "../../src/adapters/api/controllers/Auth/SignUp";
import { login } from "../../src/adapters/api/controllers/Auth/Login";
import { UserModel } from "../../src/adapters/database/models/User";
import { loginValidation } from "../../src/adapters/api/middlewares/Auth/LoginValidation";
import bcrypt from "bcryptjs";

describe("Login and signup", () => {
  let db: any;

  beforeAll(async () => {
    db = await initializeDatabase();
    await db.connect();
  });

  beforeEach(async () => {
    await db.clearDatabase();
  });

  afterAll(async () => {
    await db.closeDatabase();
  });

  it("should signup a user successfully", async () => {
    const httpRequest = httpMocks.createRequest({
      method: "POST",
      url: "/signup",
      body: {
        username: "test",
        age: 20,
        email: "test@test.com",
        password: "123456",
      },
    });

    const httpResponse = httpMocks.createResponse();

    await signUp(httpRequest, httpResponse);

    expect(httpResponse.statusCode).toBe(201);
    expect(httpResponse._getData()).toBe(
      JSON.stringify({ message: "Signup successful" })
    );
    expect(await UserModel.find({ username: "test" })).toBeTruthy();
  });

  it("should login a user successfully", async () => {
    await UserModel.create({
      username: "test",
      age: 20,
      email: "test@test.com",
      password: bcrypt.hashSync('123456'),
    });

    const httpRequest = httpMocks.createRequest({
      method: "POST",
      url: "/login",
      body: {
        email: "test@test.com",
        password: "123456",
      },
    });

    process.env.JWT_SECRET = "test";

    const httpResponse = httpMocks.createResponse();

    const next = jest.fn();

    await loginValidation(httpRequest, httpResponse, next);

    expect(next).toHaveBeenCalled();

    await login(httpRequest, httpResponse);

    expect(httpResponse.statusCode).toBe(200);
  });

  it("should not login a user with wrong credentials", async () => {
    const next = jest.fn();

    await UserModel.create({
      username: "test",
      age: 20,
      email: "test@test.com",
      password: bcrypt.hashSync('567890'),
    })

    const httpRequest = httpMocks.createRequest({
      method: "POST",
      url: "/login",
      body: {
        email: "test@test.com",
        password: "12345",
      }
    });

    const httpResponse = httpMocks.createResponse();

    await loginValidation(httpRequest, httpResponse, next);

    expect(httpResponse.statusCode).toBe(401);
  });
});
