FROM gitpod/workspace-full

USER gitpod

# Install XDebug
RUN sudo pecl channel-update pecl.php.net && sudo pecl install xdebug

USER root
# Allow XDebug to be debugger for PHP
RUN sudo apt-get update -q \
    && sudo apt-get install -y php-dev

USER gitpod

RUN wget http://xdebug.org/files/xdebug-2.9.1.tgz \
    && tar -xvzf xdebug-2.9.1.tgz \
    && cd xdebug-2.9.1 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/lib/php/20170718 \
    && echo -e '\nzend_extension = /usr/lib/php/20170718/xdebug.so' >> /etc/php/7.2/cli/php.ini
