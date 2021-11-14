FROM node:14.17.0-alpine AS build

WORKDIR /srv/app

COPY . .

RUN npm install --unsafe-perm \
    && npm run build

FROM nginx:1.18.0-alpine

ENV TZ Asia/Shanghai

COPY  --from=build /srv/app/dist/ /usr/share/nginx/html/
COPY  --from=build /srv/app/nginx/nginx.conf /etc/nginx/conf.d/

EXPOSE 8080
