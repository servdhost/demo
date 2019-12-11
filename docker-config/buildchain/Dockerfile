FROM node:8.16

RUN apt-get update && apt-get install -y apt-transport-https

WORKDIR /project

COPY ./docker-config/buildchain/.babelrc .babelrc
COPY ./docker-config/buildchain/package.json package.json
RUN npm install

COPY ./docker-config/buildchain/gulpfile.js gulpfile.js
COPY ./docker-config/buildchain/postcss.config.js postcss.config.js
COPY ./docker-config/buildchain/tailwind.config.js tailwind.config.js

CMD ./node_modules/.bin/gulp build --production