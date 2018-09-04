FROM php:7.0-fpm

RUN apt-get update && buildDeps="libpq-dev libzip-dev gnupg acl git curl nano wget libpng-dev libgmp-dev ssh libxml2-dev libmcrypt-dev python-pip" && apt-get install -y $buildDeps --no-install-recommends
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && chmod +x nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get update && buildDeps="nodejs" && apt-get install -y $buildDeps --no-install-recommends
RUN docker-php-ext-install pdo pdo_pgsql zip bcmath gd calendar pgsql pcntl sockets soap mcrypt
RUN npm install -g yarn
RUN npm install -g bower
RUN npm install -g gulp

RUN wget https://getcomposer.org/composer.phar && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer
RUN wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.10.3/php-cs-fixer.phar -O php-cs-fixer && chmod a+x php-cs-fixer && mv php-cs-fixer /usr/local/bin/php-cs-fixer
RUN composer global require phing/phing
RUN composer global require phpstan/phpstan
RUN echo "export PATH=~/.composer/vendor/bin:$PATH" > /root/.bashrc
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/docker-php-memorylimit.ini
RUN pip install --upgrade setuptools && pip install --upgrade awsebcli && pip install --upgrade "urllib3==1.22" awscli

WORKDIR /app
