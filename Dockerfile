FROM node:latest as build
WORKDIR /app
COPY ./ /app
RUN npm install  

RUN npm run build

FROM nginx:latest
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/
COPY --from=builder /app/dist/ /usr/share/nginx/html
EXPOSE 80