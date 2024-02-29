# Étape 1 : Construction de l'application
FROM node:18 as builder

WORKDIR /app

# Copier les fichiers de configuration et les dépendances package.json
COPY package.json package-lock.json ./
RUN npm install

# Copier tout le code source de l'application
COPY . .

# Construction de l'application Angular
RUN npm run build --prod

# # Étape 2 : Serveur Web Nginx
 FROM nginx:alpine
 RUN rm -rf /usr/share/nginx/html/*

# # # Copier les fichiers de build de l'application depuis l'étape 1
 COPY --from=builder /app/dist/ang /usr/share/nginx/html

# # # Exposer le port 80 pour le serveur Web Nginx
EXPOSE 8087

# # # Commande de démarrage du serveur Web
 CMD ["nginx", "-g", "daemon off;"]