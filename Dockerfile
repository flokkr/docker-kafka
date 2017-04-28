FROM elek/bigdata-base:16
ENV CONF_DIR /opt/kafka/config
ADD defaults/* defaults/
ADD url .
RUN wget `cat url` -O kafka.tar.gz && tar zxf kafka.tar.gz && rm kafka.tar.gz && mv /opt/kafka* /opt/kafka
ENV PATH /opt/kafka/bin:$PATH
CMD ["/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties"]
