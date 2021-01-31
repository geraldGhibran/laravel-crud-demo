FROM ubuntu:bionic
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx composer php7.2 php7.2-curl php7.2-common php7.2-cli php7.2-mysql php7.2-mbstring php7.2-fpm php7.2-xml php7.2-zip php7.2-bcmath -y

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;\?daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf
#COPY FILE
COPY . /var/www/html/
# Nginx config
RUN rm /etc/nginx/sites-enabled/default
ADD ./pesbuk.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/pesbuk.conf /etc/nginx/sites-enabled/pesbuk.conf
# Expose ports.
EXPOSE 8000