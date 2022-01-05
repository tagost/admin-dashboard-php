FROM mysql:5.7

ENV MYSQL_DATABASE=crud_2019 \
    MYSQL_ROOT_PASSWORD=root

COPY schema.sql /docker-entrypoint-initdb.d/

