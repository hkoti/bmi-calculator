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
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy the build directory from the build stage to the nginx directory
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
