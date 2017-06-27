FROM node:6.9.2
LABEL maintainer "pacak.daniel@gmail.com"
LABEL description "A seed project for simple Node.js app running on Kubernetes."
EXPOSE 8080
COPY server.js .
CMD node server.js

