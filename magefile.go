// +build mage

package main

import (
	"fmt"
	"net/http"

	"github.com/getlantern/errors"
	"github.com/magefile/mage/sh"
)

var name = "kafka"
var downloadPath = "/kafka/%s/kafka_2.12-%s.tgz"

func versions() map[string][]string {
	versions := make(map[string][]string)
	versions["2.3.1"] = []string{"latest", "2.3.1", "2.3", "2"}
	return versions
}

func buildImage(tag string, dir string, url string) {
	sh.Run("docker", "build", "-t", tag, "--build-arg", "URL="+url, dir)
}

func getApacheDownloadUrl(path string) (string, error) {
	url := fmt.Sprintf("https://www-eu.apache.org/dist/" + path)
	resp, err := http.Head(url)
	if err != nil {
		return "", err
	}
	if resp.StatusCode == 200 {
		return url, nil
	}
	url = fmt.Sprintf("https://archive.apache.org/dist/" + path)
	resp, err = http.Head(url)
	if err != nil {
		return "", err
	}
	if resp.StatusCode == 200 {
		return url, nil
	}
	return "", errors.New("Can't find download url for " + path)

}
func deployImage(tag string) {
	sh.Run("docker", "push", tag)
}

func buildContainer(version string, tags []string) error {
	url, err := getApacheDownloadUrl(fmt.Sprintf(downloadPath, version, version))
	if err != nil {
		return err
	}
	buildImage("flokkr/kafka:build", ".", url)
	for _, tag := range tags {
		sh.Run("docker", "tag", "flokkr/kafka:build", "flokkr/kafka:"+tag)
	}
	return nil
}

func Build() error {
	for version, tags := range versions() {
		err := buildContainer(version, tags)
		if err != nil {
			return err
		}
	}
	return nil
}

func Deploy() error {
	for _, tags := range versions() {
		for _, tag := range tags {
			deployImage("flokkr/kafka:" + tag)
		}
	}
	return nil
}
