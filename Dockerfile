# ================================
# Serve pre-built Angular artifacts
# ================================
FROM nginx:alpine

ARG APP_NAME=olympic-games-starter

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY dist/${APP_NAME}/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
