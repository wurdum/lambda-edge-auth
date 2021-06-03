FROM public.ecr.aws/lambda/nodejs:12
COPY . ./
RUN npm install
RUN npm run build
CMD [ "dist/index.lambdaHandler1" ]
