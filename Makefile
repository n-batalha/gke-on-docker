SHELL := /bin/bash

# this gets overwritten by Gitlab CI, use only for local tests
CI_COMMIT_SHA ?= 0.1

DOCKER_TAG:=docker.io/nbatalha/kube-on-docker
DOCKER_TAG_COMMIT:=$(DOCKER_TAG):$(CI_COMMIT_SHA)
DOCKER_TAG_LATEST:=$(DOCKER_TAG):latest
DOCKER_CONFIG ?= $(HOME)/.docker/

DOCKER = docker --config $(DOCKER_CONFIG)

.PHONY: build
build:
	$(DOCKER) build -t $(DOCKER_TAG_COMMIT) .

.PHONY: push-build-helper
push: build
	$(DOCKER) push $(DOCKER_TAG_COMMIT)

.PHONY: release
release:
	$(DOCKER) pull $(DOCKER_TAG_COMMIT)
	$(DOCKER) tag $(DOCKER_TAG_COMMIT) $(DOCKER_TAG_LATEST)
	$(DOCKER) push $(DOCKER_TAG_LATEST)
