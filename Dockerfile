FROM node:18

WORKDIR /srv/app

COPY ./strapi ./

RUN yarn install
RUN yarn build

EXPOSE 1337

CMD ["yarn", "start"]
