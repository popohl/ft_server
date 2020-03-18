FROM debian:buster

COPY srcs/script.sh ./

COPY utils.sh ./
CMD bash utils.sh

COPY srcs/default.conf /etc/nginx/conf.d/default.conf

CMD bash script.sh

EXPOSE 80
