FROM node:6.9.2
LABEL maintainer "pacak.daniel@gmail.com"
EXPOSE 8080
COPY server.js .
CMD node server.js

