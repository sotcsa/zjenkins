export IMAGE_NAME?=sotcsa/zjenkins
export IMAGE_VERSION?=latest
export DOCKERFILE?=docker/Dockerfile
export JENKINS_ADMIN_PASSWORD?=
export JENKINS_TRIGGER_PASSWORD?=
export SEED_TRIGGER_TOKEN?=

all: build/jenkins docker/push/jenkins

build/jenkins:
	make build/docker/image
docker/push/jenkins:
	make docker/push

build/docker/image:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) --rm=false -f $(DOCKERFILE) .
	docker tag $(IMAGE_NAME):$(IMAGE_VERSION) $(IMAGE_NAME)

docker/push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

up:
	docker-compose -f docker/docker-compose.yaml up -d

down:
	docker-compose -f docker/docker-compose.yaml down

log:
	docker-compose -f docker/docker-compose.yaml logs -f