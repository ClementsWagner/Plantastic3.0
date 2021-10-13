#!/bin/bash

docker login registry.gitlab.com/plantastic2.0

cd rest-homestation
mvn clean package
docker build -f src/main/docker/Dockerfile.jvm -t registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/rest-homestation:$1 .
docker push registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/rest-homestation:$1

cd ../rest-sensor
mvn clean package
docker build -f src/main/docker/Dockerfile.jvm -t registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/rest-sensor:$2 .
docker push registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/rest-sensor:$2


cd ../core/core-homestation
mvn clean package
docker build -f src/main/docker/Dockerfile.jvm -t registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/core-homestation:$3 .
docker push registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/core-homestation:$3

cd ../core-keycloak
mvn clean package
docker build -f src/main/docker/Dockerfile.jvm -t registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/core-keycloak:$4 .
docker push registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/core-keycloak:$4

cd ../core-sensor
mvn clean package
docker build -f src/main/docker/Dockerfile.jvm -t registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/core-sensor:$5 .
docker push registry.gitlab.com/plantastic2.0/plantastic-supersonic-subatomic-backend/core-sensor:$5
