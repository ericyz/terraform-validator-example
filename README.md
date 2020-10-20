# [Terraform Validator](https://github.com/GoogleCloudPlatform/terraform-validator) Example
## Before you start
### GCP Project
A GCP project with following APIs enabled:
* cloudbuild.googleapis.com
* cloudresourcemanager.googleapis.com
* logging.googleapis.com

### Builder Images
Under `builders/terraform` folder is the Dockerfile and Cloud Build configuration to build the Terraform & Teraform Validator image we use in this showcase.
* Version of Terraform is 0.12.24
* Version of Terraform Validator Release is 2020-09-24

To (re)build this image, run the following command in this directory.
```sh
gcloud builds submit --config=cloudbuild.yaml
```

## CI/CD using Cloud Build
This repository has a **Cloud Build auto trigger** setup on changes mades under `terraform/` folder on `master` branch. The build steps are:
* Initialize Terraform
	* `terraform init -input=false`
* Plan Terraform
	* `terraform plan -out terraform.tfplan`
* Convert Terraform Plan to JSON format
	* `terraform show -json ./terraform.tfplan > ./terraform.tfplan.json`
* Clone the forked [Policy Library](https://github.com/ericyz/policy-library) for this example
	* `git clone -b demo/terraform-validator https://github.com/ericyz/policy-library.git`
* Terraform Valdiator check against policies downloaded
	* `terraform-validator validate --policy-path ./policy-library ./terraform.tfplan.json`

Build will fail if **Terraform Valdiator** finds any violation (exit status 2)

## Manual Trigger
To test the build you can run the following command in this directory
```sh
gcloud builds submit . --config=cloudbuild/plan/cloudbuild.yaml --substitutions _BUCKET="tf-pineapple-7130"
```
