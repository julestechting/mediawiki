# MediaWiki with LDAP and PHP-Mail support
FROM synctree/mediawiki
MAINTAINER JulesTechConsulting <julestechconsulting@gmail.com>

RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
       g++ \
       libldb-dev \
       libaprutil1-dev \
       ssmtp \
    && ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/mail.ini \
    && apt-get purge -y --auto-remove g++ libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install ldap

RUN cd /usr/src/mediawiki/extensions \
    && curl https://extdist.wmflabs.org/dist/extensions/LdapAuthentication-REL1_26-70ab129.tar.gz | tar xzf - \
    && rm -f LdapAuthentication-REL1_26-70ab129.tar.gz


