
FROM node:18 as builder
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install  --legacy-peer-deps

COPY . .
RUN npm run build --prod

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/ang /usr/share/nginx/html
EXPOSE 8087
CMD ["nginx", "-g", "daemon off;"]