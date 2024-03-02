# Stage 1: Build the Angular application
FROM node:18 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app/
RUN npm run build --prod

# Stage 2: Serve the application with Nginx
FROM nginx:alpine
COPY --from=build-stage /app/dist/ang /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
