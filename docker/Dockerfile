FROM postgres:latest
ENV POSTGRES_DB=postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
COPY scripts/init.sql /docker-entrypoint-initdb.d/
