FROM nginxdemos/hello

WORKDIR /tmp
ADD entrypoint.sh .
ENTRYPOINT ["entrypoint.sh"]
