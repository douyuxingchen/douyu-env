ARG PHP_VERSION
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL


RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories ; fi


COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions
RUN chmod +x install.sh \
    && sh install.sh

ADD ./extensions/install-php-extensions  /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions

RUN apk --no-cache add tzdata \
    && apk --no-cache add bash \
    && apk --no-cache add vim \
    && apk --no-cache add git \
    && apk --no-cache add openssh \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone


# Fix: https://github.com/docker-library/php/issues/1121
RUN apk add --no-cache --repository http://${CONTAINER_PACKAGE_URL}/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php


# Install composer and change it's cache home
RUN chmod +x install-composer.sh \
    && sh install-composer.sh \
    && rm -rf /tmp/extensions
ENV COMPOSER_HOME=/tmp/composer

# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data


WORKDIR /www


# 全局配置 coding 账号和密码
# 因为composer中某些库依赖于私有库，因此你需要进行如下配置，即可使用composer拉取http协议的私有库的依赖。
ARG CODING_URL
ARG CODING_ACCOUNT
ARG CODING_PASSWORD
RUN composer config -g ${CODING_URL} ${CODING_ACCOUNT} ${CODING_PASSWORD}

# SSH密钥配置
# ssh协议拉取企业私有的composer依赖库
RUN git config --global user.name "php_container" \
    && git config --global user.email ${CODING_ACCOUNT} \
    && mkdir -p /root/.ssh && chmod 0700 /root/.ssh \
    && ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub