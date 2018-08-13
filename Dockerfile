FROM node:alpine

MAINTAINER GSMLG < me@gsmlg.org >

ENV MIRRORS_PATH /mirrors
ENV NODE_PORT 80
ENV NAME mirrors

EXPOSE 80

COPY server.js mirrors.js entrypoint.sh mirrors /

ENTRYPOINT ["/entrypoint.sh"]
