FROM fanzhihai/neokylin-mips64-base-bash:1.0

MAINTAINER liyanqing@inspur.com

COPY source/html /usr/share/nginx/html
COPY source/conf/nginx.conf /etc/nginx/nginx.conf
COPY source/ /usr/local/nginx/

WORKDIR /usr/local/nginx

RUN rm -rf html
RUN rm conf/nginx.conf
RUN ln -s /usr/share/nginx/html ./
RUN ln -s /etc/nginx/nginx.conf ./conf/
RUN cp ./conf/mime.types /etc/nginx/mime.types

WORKDIR /usr/local/nginx/sbin

EXPOSE 80

ENTRYPOINT ["./nginx","-g","daemon off;"]
