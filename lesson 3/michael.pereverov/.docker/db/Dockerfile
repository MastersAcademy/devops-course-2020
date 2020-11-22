FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -qy postgresql \
	&& apt-get purge -y --auto-remove;

RUN echo "listen_addresses = '*'" >> /etc/postgresql/12/main/postgresql.conf \
	&& echo "host    all             postgres         0.0.0.0/0            md5" >> /etc/postgresql/12/main/pg_hba.conf

EXPOSE 5432

CMD ["su", "postgres", "-c", "/usr/lib/postgresql/12/bin/postgres --config-file=/etc/postgresql/12/main/postgresql.conf"]

