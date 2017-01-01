# Kafka docker image

These images are part of the bigdata docker image series. All of the images use the same [base docker image](https://github.com/elek/docker-bigdata-base) which contains advanced configuration loading. For more detailed instruction see the [README](https://github.com/elek/docker-bigdata-base/blob/master/README.md) in the docker-bigdata-base repository.


## Configuration

The image could be configured:

* With environment variables
* With the key value store of the consul server
* With Spring config server


For examples and more details see the [repository](https://github.com/elek/docker-bigdata-base) of the base image.

## Running

Using the image depends from the configuration loading and the exact use case. You can find multiple examples in [this](https://github.com/elek/bigdata-docker) repository to use the images:

* on the local machine using docker-compose
* on remote cluster using ansible 
* on remote cluster and local macine with using docker-compose downloaded from the consul image. 

As a minimum you need a zookeeper instance and a kafka instance.

For example:

```
version: "2"
services:
   zookeeper:
      image: elek/zookeeper
      network_mode: host
   kafka:
      image: elek/kafka
      network_mode: host
```

Note: this setup uses host networking mode which simplifies the configuration as the zookeeper service is available from the localhost.

### Smoketest

You can follow the examples from the [kafka quickstart](https://kafka.apache.org/quickstart) documentation.

If you used the host networking (as the example above) you can run the commands as:

```
docker run --net=host --rm  elek/kafka /opt/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181
```

## Versioning policy

  The latest tag points to the latest configuration loading and the latest stable apache version.

  If there is plain version tag without prefix it is synchronized with the version of the original apache software.

  It there is a prefix (eg. HDP) it includes a specific version from a specific distribution.

  As the configuration loading in the base image is constantly evolving even the tags of older releases may be refreshed over the time.


