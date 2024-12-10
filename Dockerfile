# Build stage
FROM node:18 AS build

WORKDIR /app

ENV NODE_OPTIONS="--openssl-legacy-provider"

COPY * .

RUN npm install
RUN npm run build

# Production stage (same base image as build stage)
FROM node:18

WORKDIR /app

COPY --from=build /app/node_modules .

COPY --from=build /app/build .

EXPOSE 3000

CMD ["npm", "start"]

