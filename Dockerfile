FROM node:12-alpine as build

COPY . /src
WORKDIR /src

RUN npm install
RUN npm run build

FROM public.ecr.aws/lambda/nodejs:12

COPY --from=build /src/package*.json ./
RUN npm install --only=production

COPY --from=build /src/dist ./

CMD [ "index.httpHeadersHandler" ]
