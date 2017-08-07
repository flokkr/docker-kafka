FROM flokkr/base:19
ENV CONF_DIR /opt/kafka/config
ADD url .
RUN wget `cat url` -O kafka.tar.gz && tar zxf kafka.tar.gz && rm kafka.tar.gz && mv /opt/kafka* /opt/kafka
ENV PATH /opt/kafka/bin:$PATH
WORKDIR /opt/kafka
CMD ["/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties"]
