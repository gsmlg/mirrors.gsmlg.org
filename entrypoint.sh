#!/bin/sh

set -e

NODE_PORT=${NODE_PORT:-80}

export NODE_PORT

[ ! -d mirrors ] && mkdir mirrors
[ ! -d sites ] && mkdir sites

cat <<EOF > /sites/mirrors
upstream mirrors {
  server ${NAME}:${NODE_PORT};
}

server {
  listen 80;
  listen [::]:80;
  server_name ${SERVER_NAME};

  access_log /var/log/nginx/mirrors.access.log;
  error_log /var/log/nginx/mirrors.error.log;

  location / {
    add_header Access-Control-Allow-Origin *;
    add_header Access-Remote-Addr \$remote_addr;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header host \$host;
    proxy_pass http://mirrors;
  }
}

server {
  listen [::]:443 ssl http2;
  listen 443 ssl http2;
  server_name ${SERVER_NAME};

  access_log /var/log/nginx/mirrors.access.log;
  error_log /var/log/nginx/mirrors.error.log;

  include /etc/nginx/ssl.conf;

  location / {
    add_header Access-Control-Allow-Origin *;
    add_header Access-Remote-Addr \$remote_addr;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header host \$host;
    proxy_pass http://mirrors;
  }
}
EOF

node /server.js

