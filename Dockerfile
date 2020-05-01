ARG BASE=latest
FROM flokkr/base:${BASE}
ARG ARTIFACTDIR
ENV CONF_DIR /opt/kafka/config
ENV PATH /opt/kafka/bin:$PATH
RUN useradd --uid 1000 kafka --gid 1000 --home /opt/kafka && chown kafka /opt
USER kafka
ADD --chown=kafka:flokkr ${ARTIFACTDIR} /opt/kafka
WORKDIR /opt/kafka
CMD ["/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties"]
