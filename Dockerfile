FROM hobord/alpine-ngnix-php7-fpm-devenv
MAINTAINER Balazs Szabo <balazs.szabo@gmail.com>
ADD files/nginx.conf /etc/nginx/

RUN ln -s /usr/bin/php7 /usr/bin/php
RUN php7 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php7 -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php7 composer-setup.php && mv composer.phar /usr/local/bin/composer && rm composer-setup.php
RUN /usr/local/bin/composer self-update

VOLUME ["/DATA","/DATA/htdocs"]
