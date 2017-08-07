

VERSION ?= latest
URL ?= "http://xenia.sote.hu/ftp/mirrors/www.apache.org/kafka/0.10.2.1/kafka_2.11-0.10.2.1.tgz"

build:
	echo $(URL) > url
	docker build -t flokkr/kafka:$(VERSION) .

deploy:
	docker push flokkr/kafka:$(VERSION)

.PHONY: deploy build
