FROM node:18 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN  npm install --legacy-peer-deps
COPY ./ /app/
RUN npm run build --prod

# Stage 2: Serve the application with Nginx
FROM nginx:alpine
COPY --from=build-stage /app/dist/ang /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf