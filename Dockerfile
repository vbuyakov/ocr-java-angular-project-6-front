# ================================
# Stage 1: Build Angular application
# ================================
FROM node:24-alpine AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code and build
COPY . .
RUN npm run build -- --configuration=production

# ================================
# Stage 2: Serve with Nginx
# ================================
FROM nginx:alpine

ARG APP_NAME=olympic-games-starter

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/${APP_NAME}/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
