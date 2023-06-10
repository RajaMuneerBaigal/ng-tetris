FROM node:lts-alpine as base
RUN apk update
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=base /app/dist/ng-tetris .
ENTRYPOINT ["nginx", "-g","daemon off;"]
