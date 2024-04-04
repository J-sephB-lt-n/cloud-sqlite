build_push_container_to_google_artifact_registry:
	gcloud config set project $(GCP_PROJECT_ID)
	gcloud config set run/region $(GCP_REGION)
	docker buildx build \
		--platform linux/amd64 \
		--tag $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(GCP_ARTIFACT_REG_REPO_NAME)/$(CONTAINER_NAME) \
		.
	docker push \
		$(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(GCP_ARTIFACT_REG_REPO_NAME)/$(CONTAINER_NAME)

deploy_google_cloud_run_service:
	gcloud config set project $(GCP_PROJECT_ID)
	gcloud config set run/region $(GCP_REGION)
	gcloud run deploy $(CLOUD_RUN_SERVICE_NAME) \
		--image $(GCP_REGION)-docker.pkg.dev/$(GCP_PROJECT_ID)/$(GCP_ARTIFACT_REG_REPO_NAME)/$(CONTAINER_NAME) \
		--max-instances 1 \
		--min-instances 0 \
		--allow-unauthenticated \
		--timeout 30 \
		--set-env-vars "BACKUP_DB_EVERY_N_SECONDS=10"
