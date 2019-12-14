#!/bin/sh
set -e

if [ -z "${INPUT_NAME}" ]; then
  echo "Unable to find the repository name. Did you set with.name?"
  exit 1
fi

if [ -z "${INPUT_USERNAME}" ]; then
  echo "Unable to find the username. Did you set with.username?"
  exit 1
fi

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Unable to find the password. Did you set with.password?"
  exit 1
fi


if [ -z "${TAG}" ]; then
    DOCKER_TAG="latest"
fi

BRANCH=$(echo ${GITHUB_REF} | sed -e "s/refs\/heads\///g")

if [ "${BRANCH}" == "master" ]; then
  BRANCH="latest"
fi;


echo ${INPUT_PASSWORD} | docker login -u ${INPUT_USERNAME} --password-stdin ${INPUT_REGISTRY}

docker build -t ${INPUT_NAME}:latest -t ${INPUT_NAME}:${DOCKER_TAG} .
docker push ${INPUT_NAME}:latest
docker push ${INPUT_NAME}:${DOCKER_TAG}





docker logout