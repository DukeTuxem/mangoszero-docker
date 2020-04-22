FROM mysql:5.7

WORKDIR /mangos-zero

RUN chown 1000:1000 . && chmod 755 .

COPY automatic_install.sh /docker-entrypoint-initdb.d/

# Database is accessible to normal user
USER 1000:1000
