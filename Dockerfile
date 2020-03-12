FROM debian:buster

COPY script.sh ./
COPY srcs/default.conf /etc/nginx/conf.d/default.conf

CMD bash script.sh

EXPOSE 80
