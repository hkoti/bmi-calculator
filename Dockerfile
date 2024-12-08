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

# Production stage
FROM nginx:alpine

# Copy the build directory from the build stage to the nginx directory
COPY --from=build /app/node_modules . 

EXPOSE 3000
CMD ["npm start"]
