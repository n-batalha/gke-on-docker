SHELL := /bin/bash

# this gets overwritten by Gitlab CI
CI_COMMIT_SHA ?= 0.0.0.1

DOCKER_TAG:=gcr.io/$(GCLOUD_PROJECT)/kube-on-docker
DOCKER_TAG_COMMIT:=$(DOCKER_TAG):$(CI_COMMIT_SHA)
DOCKER_TAG_LATEST:=$(DOCKER_TAG):latest

.PHONY: build
build:
	docker build -t $(DOCKER_TAG_COMMIT) .

.PHONY: push-build-helper
push: build
	gcloud \
		--project=$(GCLOUD_PROJECT) \
		--configuration=$(GCLOUD_CONFIGURATION) \
		docker -- push $(DOCKER_TAG_COMMIT)

.PHONY: release
release:
	gcloud \
		--project=$(GCLOUD_PROJECT) \
		--configuration=$(GCLOUD_CONFIGURATION) \
		docker -- pull $(DOCKER_TAG_COMMIT)

	docker tag $(DOCKER_TAG_COMMIT) $(DOCKER_TAG_LATEST)
	gcloud \
		--project=$(GCLOUD_PROJECT) \
		--configuration=$(GCLOUD_CONFIGURATION) \
		docker -- push $(DOCKER_TAG_LATEST)
