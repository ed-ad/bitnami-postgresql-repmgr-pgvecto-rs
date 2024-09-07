ARG BITNAMI_TAG=16.3.0-debian-12-r11

FROM docker.io/bitnami/postgresql-repmgr:${BITNAMI_TAG}
ADD "https://github.com/tensorchord/pgvecto.rs/releases/download/v0.3.0/vectors-pg16_0.3.0_arm64.deb" /tmp/vectors.deb
USER root
RUN apt-get update && apt-get install -y libjemalloc2 && apt-get install -y /tmp/vectors.deb && rm -f /tmp/vectors.deb && \
     mv /usr/lib/postgresql/*/lib/vectors.so /opt/bitnami/postgresql/lib/ && \
     mv usr/share/postgresql/*/extension/vectors* opt/bitnami/postgresql/share/extension/
USER 1001
ENV POSTGRESQL_EXTRA_FLAGS="-c shared_preload_libraries=vectors.so"

