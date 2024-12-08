# Build stage
FROM node:18 AS build

WORKDIR /app

ENV NODE_OPTIONS="--openssl-legacy-provider"

COPY package.json .
COPY package-lock.json .

COPY images/ ./images/
COPY src/ ./src/
COPY public/ ./public/

RUN npm install

# Production stage (same base image as build stage)
FROM node:18

WORKDIR /app

COPY --from=build /app /app

EXPOSE 3000

CMD ["npm", "start"]

