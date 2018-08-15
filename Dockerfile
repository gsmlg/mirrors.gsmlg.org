FROM node:alpine

MAINTAINER GSMLG < me@gsmlg.org >

ENV MIRRORS_PATH=/mirrors \
    NODE_PORT=80 \
    SERVER_MODE=master \
    MASTER_URL="" \
    NAME=mirrors \
    SERVER_NAME=mirrors.gsmlg.org

EXPOSE 80

COPY server.js mirrors.js entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
