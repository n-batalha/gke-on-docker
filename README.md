# GKE in Docker

This is just an extension of [Docker in Docker](https://hub.docker.com/_/docker) to include
 the [Google Cloud SDK](https://github.com/GoogleCloudPlatform/cloud-sdk-docker/) to have
 an image to deploy from Gitlab CI or similar.

## Usage

Just use the image in [Docker Hub](https://hub.docker.com/r/nbatalha/kube-on-docker/) 
on your Gitlab CI `image` tags, or build one yourself (instructions below to setup in Gitlab CI).

## Development instructions

1. Create a Docker Hub account
2. On the Gitlab CI setup the secret for:
  * `DOCKER_AUTH_CONFIG` (The auth variable of Docker Hub in `~/.docker/config.json`, see [here](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/configuration/advanced-configuration.md#using-a-private-container-registry))
3. Build and push once locally to make the image available for Gitlab CI
4. Enjoy

## References

* https://docs.gitlab.com/ce/ci/docker/using_docker_build.html#use-docker-in-docker-executor