import { lh1 } from "./lambdaHandler1";

export const lambdaHandler1 = lh1;

export const lambdaHandler2 = async () => {
    return { handler: "handler2" };
}

export const lambdaHandler3 = async () => {
    return { handler: "handler3" };
}
