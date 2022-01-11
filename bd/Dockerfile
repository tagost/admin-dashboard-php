#FROM mysql:5.7
FROM bitnami/mysql:8.0.27-debian-10-r63

ENV MYSQL_DATABASE=crud_2019 \
    MYSQL_ROOT_PASSWORD=root

COPY schema.sql /docker-entrypoint-initdb.d/

