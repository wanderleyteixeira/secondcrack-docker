FROM alpine:3.9

MAINTAINER Wanderley Teixeira <wanderley@linux.com>

# Timezone
ENV TIMEZONE America/Toronto

# Update and installation of packages
RUN apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
	apk add --no-cache \
		bash \
		curl \
		git \
		inotify-tools \
		nginx \
		openssh-client \
		php7 \
        php7-dom \
        php7-calendar \
        php7-ctype \
        php7-curl \
        php7-fileinfo \
        php7-fpm \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-posix \
        php7-simplexml \
        php7-session \
        php7-tokenizer \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
		supervisor && \
	sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php7/php.ini && \
	sed -i "s|;cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|" /etc/php7/php.ini && \
	apk del tzdata && \
    rm -fr /tmp/*.apk && \
    rm -rf /var/cache/apk/*

# Main
COPY run.sh /home/run.sh
RUN mkdir -p /home/secondcrack

# For PHP
COPY php.ini.secondcrack /etc/php7/php.ini 

# For nginx
COPY nginx_default.conf /etc/nginx/conf.d/default.conf
RUN mkdir -p /run/nginx
RUN touch /var/log/nginx/access.log && touch /var/log/nginx/error.log
RUN mkdir -p /etc/service/nginx
ADD nginx.sh /etc/service/nginx/run

# For supervisor
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# For inotify
RUN mkdir -p /etc/service/inotify
ADD refresh.sh /etc/service/inotify/run

# For changes in /home/secondcrack
COPY refresh.sh /home/refresh.sh

# Expose ports
EXPOSE 80

CMD ["/home/run.sh"]

