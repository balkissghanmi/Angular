FROM node:latest as build
WORKDIR /app

COPY package*.json /app/
RUN npm install  
COPY ./ /app/
RUN npm run build

FROM nginx:latest
COPY --from=build /app/dist/ang /usr/share/nginx/html
EXPOSE 80