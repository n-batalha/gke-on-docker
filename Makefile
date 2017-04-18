SHELL := /bin/bash

# this gets overwritten by Gitlab CI, use only for local tests
CI_COMMIT_SHA ?= 0.1

DOCKER_TAG:=docker.io/nbatalha/kube-on-docker
DOCKER_TAG_COMMIT:=$(DOCKER_TAG):$(CI_COMMIT_SHA)
DOCKER_TAG_LATEST:=$(DOCKER_TAG):latest

.PHONY: build
build:
	docker build -t $(DOCKER_TAG_COMMIT) .

.PHONY: push-build-helper
push: build
	docker push $(DOCKER_TAG_COMMIT)

.PHONY: release
release:
	docker pull $(DOCKER_TAG_COMMIT)
	docker tag $(DOCKER_TAG_COMMIT) $(DOCKER_TAG_LATEST)
	docker push $(DOCKER_TAG_LATEST)
