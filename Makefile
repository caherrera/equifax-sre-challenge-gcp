GOOGLE_CLOUD_PROJECT                := $(shell gcloud config get-value project)
GOOGLE_APPLICATION_CREDENTIALS_FILE := "$(GOOGLE_CLOUD_PROJECT)-sa.json"
GOOGLE_IAM_ACCOUNT                  := terraform@$(GOOGLE_CLOUD_PROJECT).iam.gserviceaccount.com

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

