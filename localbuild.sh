set -e
DOCKER_TAG=${DOCKER_TAG:-latest}
docker build -t elek/kafka:$DOCKER_TAG .
