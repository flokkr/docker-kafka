

VERSION ?= latest
URL ?= "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=/kafka/2.1.0/kafka_2.12-2.1.0.tgz"

build:
	echo $(URL) > url
	docker build --build-arg URL=$(URL) -t flokkr/kafka:$(VERSION) .

deploy:
	docker push flokkr/kafka:$(VERSION)

.PHONY: deploy build
