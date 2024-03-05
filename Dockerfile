FROM node:latest as build-stage
WORKDIR /app
COPY ./ /app
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=build-stage /app/dist/ang /usr/share/nginx/html
EXPOSE 80

