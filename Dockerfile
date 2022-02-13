FROM node:latest AS builder

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN yarn && yarn build

FROM nginx

COPY --from=builder /app/build/ /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


