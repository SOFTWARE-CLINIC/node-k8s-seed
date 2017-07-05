FROM node:6.9.2
LABEL maintainer "pacak.daniel@gmail.com"
LABEL description "A seed project for simple Node.js app running on Kubernetes."
EXPOSE 8080

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app
COPY . /usr/src/app

RUN npm install
CMD node server.js
