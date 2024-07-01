import * as jwt from "jsonwebtoken";
import { Types } from "mongoose";
import { sign, verify } from "../../../src/utils/Token";

describe("sign", () => {
  test("Signs a token correctly", () => {
    process.env.JWT_SECRET = "test";

    const data = { uid: new Types.ObjectId() as any };

    const token = sign(data);

    expect(token).toBeTruthy();

    const decodedData = jwt.decode(token) as { uid: string };
    expect(decodedData.uid).toEqual(data.uid.toString());
  });

  test("Try to sign before a secret is defined", () => {
    delete process.env.JWT_SECRET;

    const data = { uid: new Types.ObjectId() as any };

    const token = sign(data);

    expect(token).toEqual("JWT_SECRET_NOT_FOUND");
  });
});

describe("verify", () => {
  test("Verifies a valid token correctly", () => {
    process.env.JWT_SECRET = "test";

    const data = { uid: new Types.ObjectId() as any };

    const token = sign(data);

    const decodedData = verify(token);
    expect(typeof decodedData).not.toBe("string");
  });

  test("Try to verify without a jwt_secret", () => {
    delete process.env.JWT_SECRET;

    const token = sign({ uid: new Types.ObjectId() as any });

    expect(verify(token)).toEqual("JWT_SECRET_NOT_FOUND");
  });

  test("Try to verify an invalid token", () => {
    process.env.JWT_SECRET = "test";

    const invalidToken = "invalid_token";

    expect(verify(invalidToken)).toEqual("INVALID_TOKEN");
  });

  test("Try to verify an invalid token", () => {
    process.env.JWT_SECRET = "test";

    const decodedData = verify("invalid_token");

    expect(typeof decodedData).toBe("string");
  });
});
