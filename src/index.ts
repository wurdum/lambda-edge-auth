import * as checkAuth from "./check-auth";
import * as httpHeaders from "./http-headers";
import * as parseAuth from "./parse-auth";
import * as refreshAuth from "./refresh-auth";
import * as signOut from "./sign-out";

export const checkAuthHandler = checkAuth.handler;
export const httpHeadersHandler = httpHeaders.handler;
export const parseAuthHandler = parseAuth.handler;
export const refreshAuthHandler = refreshAuth.handler;
export const signOutHandler = signOut.handler;
