ARG centos_ver=8
ARG grafana_ver=6.7.2

FROM centos:${centos_ver}

ARG grafana_ver

LABEL author=jrpamid.cloudops@gmail.com \
      app_name=grafana \
      app_version=6.7.2 \
      app_description="OpenSource Dashboard tool"

ENV GRAFANA_PKG=grafana-${grafana_ver}.linux-amd64.tar.gz 
ENV GRAFANA_URL=https://dl.grafana.com/oss/release/${GRAFANA_PKG} \
    GRAFANA_USER=grafana \
    PATH=$PATH:/opt/grafana/bin:/opt/grafana/scripts 

COPY files-to-add/scripts/ /tmp/scripts/


RUN yum update -y \
    && yum install -y wget tar gzip \
    && mkdir -p /opt/grafana \
    && mkdir -p /grafana/data \
    && mkdir -p /opt/grafana/{scripts,custom_config} \
    && groupadd ${GRAFANA_USER} \
    && useradd -g ${GRAFANA_USER} -r ${GRAFANA_USER} \
    && cd /tmp \
    && wget ${GRAFANA_URL} \
    && tar -xvzf /tmp/${GRAFANA_PKG} -C /opt/grafana --strip-components=1 \
    && mv /tmp/scripts /opt/grafana/scripts \
    && chown -R ${GRAFANA_USER}:${GRAFANA_USER} /opt/grafana \
    && chown -R ${GRAFANA_USER}:${GRAFANA_USER} /grafana/data \
    && chmod -R 755 /opt/grafana \
    && chmod -R 755 /grafana/data \
    && rm -Rf /tmp/${GRAFANA_PKG} \
    && rm -Rf /tmp/scripts \
    && yum clean all  
    

USER ${GRAFANA_USER}

WORKDIR /opt/grafana/bin

EXPOSE 3000    

ENTRYPOINT ["grafana-server"]
CMD ["--config","/opt/grafana/conf/sample.ini"]
