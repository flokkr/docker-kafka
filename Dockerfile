FROM flokkr/base:33
ENV CONF_DIR /opt/kafka/config
ENV PATH /opt/kafka/bin:$PATH
ARG URL
RUN wget $URL -O kafka.tar.gz && tar zxf kafka.tar.gz && rm kafka.tar.gz && mv /opt/kafka* /opt/kafka
WORKDIR /opt/kafka
CMD ["/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties"]
