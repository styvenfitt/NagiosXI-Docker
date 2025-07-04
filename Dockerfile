FROM ubuntu:22.04
LABEL maintainer="cbpeckles"

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar dependencias necesarias para Nagios XI
RUN apt-get update && \
    apt-get install -y \
    wget unzip net-tools curl \
    php php-cli php-mysql php-gd php-xml php-mbstring php-curl \
    apache2 \
    gcc build-essential libgd-dev make snmp libssl-dev \
    tar mysql-client sudo cron rsyslog \
    lsb-release ca-certificates \
    passwd adduser login \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
    
# install nagiosxi
# download and extract the latest version of Nagios XI
# Note: The version number in the URL should be updated to the latest version as needed.
# The version in this example is 5.11.3, but you should check for the latest version on the Nagios website.
# The URL is subject to change, so ensure you have the correct link.
# Note: The URL in the original script was incorrect (it had a 't' at the beginning).
# The correct URL should not have that 't' and should be a valid link to the Nagios XI tarball.
# The URL below is an example and should be verified for the latest version.
# Note: The original script used 'xi-latest.tar.gz', but it's better to specify the version for consistency.
RUN mkdir /tmp/nagiosxi \ 
    && wget -qO- https://assets.nagios.com/downloads/nagiosxi/5/xi-5.11.3.tar.gz | tar -xz -C /tmp

WORKDIR /tmp/nagiosxi

# overwrite custom config file
ADD config.cfg xi-sys.cfg

RUN ls -l /tmp/nagiosxi

# start building
RUN chmod +x init.sh
RUN ./init.sh
RUN . ./xi-sys.cfg
RUN umask 0022
RUN . ./functions.sh && log="install.log"
RUN export INTERACTIVE="False" \
    && export INSTALL_PATH=`pwd`
RUN . ./functions.sh \
    && run_sub ./0-repos noupdate
RUN . ./functions.sh \
    && run_sub ./1-prereqs
RUN . ./functions.sh \
    && run_sub ./2-usersgroups
RUN . ./functions.sh \
    && run_sub ./3-dbservers
RUN . ./functions.sh \
    && run_sub ./4-services
RUN . ./functions.sh \
    && run_sub ./5-sudoers
RUN sed -i.bak s/selinux/sudoers/g 9-dbbackups
RUN . ./functions.sh \
    && run_sub ./9-dbbackups
RUN . ./functions.sh \
    && run_sub ./11-sourceguardian
RUN . ./functions.sh \
    && run_sub ./13-phpini

ADD scripts/NDOUTILS-POST subcomponents/ndoutils/post-install
ADD scripts/install subcomponents/ndoutils/install
RUN chmod 755 subcomponents/ndoutils/post-install \
    && chmod 755 subcomponents/ndoutils/install \
	&& . ./functions.sh \
	&& run_sub ./A-subcomponents \
	&& run_sub ./A0-mrtg

    
ADD config.inc.php /usr/local/nagiosxi/html/config.inc.php
RUN chown www-data:www-data /usr/local/nagiosxi/html/config.inc.php

RUN . ./functions.sh \
    && run_sub ./C-cronjobs
RUN . ./functions.sh \
    && run_sub ./D-chkconfigalldaemons

RUN . ./functions.sh \
    && run_sub ./F-startdaemons
RUN . ./functions.sh \
    && run_sub ./Z-webroot

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# set startup script
ADD start.sh /start.sh
RUN chmod 755 /start.sh
EXPOSE 80 5666 5667

CMD ["/start.sh"]
