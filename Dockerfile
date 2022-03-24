FROM alpine:3.11

LABEL Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.4 based on Alpine Linux (forked from trafex/alpine-nginx-php7)."

# Install packages
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add php \
  php-fpm \
  php-opcache \
  php-openssl \
  php-curl \
  php7-pdo \
  php7-pdo_mysql \
  php7-mysqli \
  nginx \
  supervisor \
  curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
#RUN chown -R nobody.nobody /var/www/html && \
#  chown -R nobody.nobody /run && \
#  chown -R nobody.nobody /var/lib/nginx && \
#  chown -R nobody.nobody /var/log/nginx

# Switch to use a non-root user from here on
#USER nobody

# Add application
WORKDIR /var/www/html
#COPY --chown=nobody . /var/www/html/
COPY . /var/www/html/
#RUN chmod -R 777 /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping
