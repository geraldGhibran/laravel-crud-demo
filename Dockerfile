FROM ubuntu:bionic
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install mysql-server systemd nano nginx composer php7.2 php7.2-curl php7.2-common php7.2-cli php7.2-mysql php7.2-mbstring php7.2-fpm php7.2-xml php7.2-zip php7.2-bcmath -y

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;\?daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf
#COPY FILE
COPY . /var/www/html/
# Nginx config
RUN rm /etc/nginx/sites-enabled/default
ADD ./pesbuk.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/pesbuk.conf /etc/nginx/sites-enabled/pesbuk.conf
RUN nginx -t
# RUN systemctl restart nginx
# RUN sh -c 'cd /var/www/html && composer install && php artisan key:generate'
RUN cd /var/www/html && composer install && php artisan key:generate
RUN chmod -R 775 /var/www/html/ && chown -R root:www-data /var/www/html
RUN chmod -R 775 /var/www/html/* && chown -R root:www-data /var/www/html/*

RUN ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
RUN service mysql restart

# Expose ports.

EXPOSE 81
# RUN PHP and NGINX
CMD service php7.2-fpm start && nginx