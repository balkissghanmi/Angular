# Stage 1: Build the Angular app
FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine
COPY --from=build-stage /app/dist/your-app-name /usr/share/nginx/html
