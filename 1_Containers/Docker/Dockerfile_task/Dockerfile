FROM ubuntu:bionic

LABEL description="ubuntu 18.04 + apache2 + ntp + jdk"

ARG JAVA_VERSION=8
ARG JAVA_RELEASE=JDK

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /var/www/site

RUN bash -c ' \
    set -euxo pipefail && \
    apt-get update && \
    pkg="openjdk-$JAVA_VERSION"; \
    if [ "$JAVA_RELEASE" = "JDK" ]; then \
        pkg="$pkg-jdk-headless"; \
    else \
        pkg="$pkg-jre-headless"; \
    fi; \
    apt-get install -y --no-install-recommends "$pkg" && \
    apt-get install -y apache2 && \
    apt-get install -y ntp && \
    apt clean'

COPY profile.d/java.sh /etc/profile.d/

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

ADD web/www /var/www/site/app

ENV JAVA_HOME=/usr

EXPOSE 8081:80

CMD /usr/sbin/apache2ctl -D FOREGROUND