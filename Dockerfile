FROM public.ecr.aws/lambda/nodejs:12
COPY dist/* package*.json ./
RUN npm install
CMD [ "index.lambdaHandler1" ]
