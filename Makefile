#GOOGLE_CLOUD_PROJECT                := $(shell gcloud config get-value project)
GOOGLE_APPLICATION_CREDENTIALS_FILE := "$(GOOGLE_CLOUD_PROJECT)-sa.json"
GOOGLE_IAM_ACCOUNT                  := terraform@$(GOOGLE_CLOUD_PROJECT).iam.gserviceaccount.com
DOCKER_REGISTRY                     := $(GOOGLE_CLOUD_REGION)-docker.pkg.dev
IMAGE_TAG   					    := $(shell git rev-parse --short HEAD)
CONTAINER_NAME                      := $(DOCKER_REGISTRY)/$(GOOGLE_CLOUD_PROJECT)/dev-wordpress/hola-mundo:${IMAGE_TAG}
DOCKER_KEY_FILE                     := $(GOOGLE_APPLICATION_CREDENTIALS_FILE)
GKE_CLUSTER_NAME                    := dev-wordpress-gke

enable-services-resourcemanager:
	gcloud services enable resourcemanager.googleapis.com ;


create-sa:
	gcloud iam service-accounts create terraform \
        --display-name="Terraform Admin" ; \
	gcloud projects add-iam-policy-binding $(GOOGLE_CLOUD_PROJECT) \
        --member="serviceAccount:$(GOOGLE_IAM_ACCOUNT)" \
        --role="roles/owner" ; \
	gcloud iam service-accounts keys create $(GOOGLE_APPLICATION_CREDENTIALS_FILE) \
        --iam-account="$(GOOGLE_IAM_ACCOUNT)"


info:
	@echo $(CONTAINER_NAME) ;

login-gcr:
	gcloud auth configure-docker $(DOCKER_REGISTRY)

docker-login:
	docker login $(DOCKER_REGISTRY)

docker-build:
	docker build -t $(CONTAINER_NAME) .

docker-push:
	docker push $(CONTAINER_NAME)

docker-run:
	docker run -u$(shell id -u):$(shell id -g) -v $(shell pwd)/src:/app -it --rm $(CONTAINER_NAME) bash

create-image-pull-secret:
	kubectl create secret docker-registry gcr-json-key \
		--docker-server=$(DOCKER_REGISTRY) \
		--docker-username=_json_key \
		--docker-password="`cat $(DOCKER_KEY_FILE)`"

gcloud-list-clusters:
	gcloud container clusters list

gcloud-get-credentials:
	gcloud container clusters get-credentials $(GKE_CLUSTER_NAME) --region $(GOOGLE_CLOUD_REGION)

helm-install:
	helm upgrade --install hola-mundo ./helm/hola-mundo --set image.tag=$(IMAGE_TAG)

k-create-namespace:
	kubectl create namespace hola-mundo

create-env-vars:
	kubectl create secret generic laravel --from-env-file=src/.env
