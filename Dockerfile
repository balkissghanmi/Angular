# Build stage
FROM node:latest as build-stage
WORKDIR /app
COPY ./ /app
RUN npm install
RUN npm run build

# Serve stage
FROM nginx:alpine
COPY --from=build-stage /app/dist/ang /usr/share/nginx/html
EXPOSE 80

