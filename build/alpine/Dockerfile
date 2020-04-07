# defaults to latest alpine version
ARG alpine_ver=latest
# defaults to latest stable grafana version
ARG grafana_ver=6.7.2

FROM alpine:${alpine_ver}
ARG grafana_ver

# Setting environment variables
ENV GRAFANA_PKG=grafana-${grafana_ver}.linux-amd64.tar.gz
ENV GRAFANA_HOME=/opt/grafana \
    GRAFANA_DATA=/grafana/data \
    GRAFANA_URL=https://dl.grafana.com/oss/release/${GRAFANA_PKG} \
    # glibc package is required for running c compiled programs
    GLIBC_DOWNLOAD_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk \
    GLIBC_DOWNLOAD_KEY=https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \ 
    GRAFANA_USER=grafana

COPY ["files-to-add", "/tmp/"]

RUN apk update && set -x \
    && apk add --no-cache ca-certificates tar wget unzip bash \
    && addgroup ${GRAFANA_USER} \
    && adduser -S -G ${GRAFANA_USER} ${GRAFANA_USER} \
    && cd /tmp \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub ${GLIBC_DOWNLOAD_KEY} \
    && wget -q ${GLIBC_DOWNLOAD_URL} \
    && apk add glibc-2.31-r0.apk \
    && wget -q ${GRAFANA_URL} -O ${GRAFANA_PKG} \
    && mkdir -p ${GRAFANA_HOME} ${GRAFANA_HOME}/logs ${GRAFANA_HOME}/scripts \
    && mkdir -p ${GRAFANA_DATA} ${GRAFANA_DATA}/plugins ${GRAFANA_DATA}/dashboards ${GRAFANA_DATA}/provisioning \
    && tar xzf ${GRAFANA_PKG} -C ${GRAFANA_HOME} --strip-components=1 \
    && cp /tmp/conf/* ${GRAFANA_HOME}/conf \
    && chmod -R 775 ${GRAFANA_HOME} ${GRAFANA_DATA} \
    && chown -R ${GRAFANA_USER}:${GRAFANA_USER} ${GRAFANA_HOME} ${GRAFANA_DATA} \
    && cp ${GRAFANA_HOME}/bin/grafana-server ${GRAFANA_HOME}/bin/grafana-cli  /usr/local/bin \
    && rm -Rf /tmp/grafana* /tmp/scripts /tmp/conf /var/cache/apk/* /tmp/${GRAFANA_PKG} 

WORKDIR "${GRAFANA_HOME}/bin"

USER ${GRAFANA_USER}    

EXPOSE 3000

LABEL maintainer=jrpamid.cloudops@gmail.com \
      app_name=grafana \
      app_version=${grafana_ver} \
      app_description="Opensource Dashboard Tool"

ENTRYPOINT ["grafana-server"]
CMD ["--config" , "/opt/grafana/conf/grafana.ini"]

