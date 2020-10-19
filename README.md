# annz.cloud Config Validation Showcase

## CI/CD using Cloud Build

## Builder Images

### Terraform
Under `builders/terraform` folder is the Dockerfile and Cloud Build configuration to build the Terraform image we use in this showcase. Version of Terraform is 0.11.14

To (re)build this image, run the following command in this directory.
```sh
gcloud builds submit --config=cloudbuild.yaml
```

### Terraform Validator
Under `builders/validator` folder is the Dockerfile and Cloud Build configuration to build the Terraform Validator image we use in this showcase. Version of Terraform Validator packaged is from Release 2019-06-11

To (re)build this image, run the following command in this directory.
```sh
gcloud builds submit --config=cloudbuild.yaml
```

## Build Steps
This repository has a **Cloud Build auto trigger** setup on changes mades under `terraform/` folder (all branches). The build steps are:
* Initialize Terraform
	* `terraform init`
* Plan Terraform
	* `terraform plan -out terraform.tfplan`
* Convert Terraform Plan
	* `terraform-validator convert terraform/terraform.tfplan`
* Clone latest Policy Library
	* `gcloud source repos clone policy-library`
	* Note: from `policy-library` repository under the same project
* Terraform Valdiator check against policies downloaded
	* `terraform-validator validate terraform/terraform.tfplan --policy-path=./policy-library/`

Build will fail if **Terraform Valdiator** finds any violation (exit status 2)

### Manual Trigger
To test the build you can run the following command in this directory
```sh
gcloud builds submit . --config=cloudbuild/plan/cloudbuild.yaml --substitutions _BUCKET="tf-pineapple-7130",_PROJECT="project-pineapple-7130"
```

## Terram module
Under `terraform` folder you will find the Terraform module to create GCP resources for testing against constraints from the Policy Library

TODO: Fix the folder and project names
TODO: Change default bucket location to Singapore

## Playbook

### Test Case: GCS Bucket location

### Showcase Cloud Build Auto Trigger with no Policies

Checked

### Showcase with 1 Policy and violation

Assuming Cloud Build Auto Trigger works from previous step

Checked

### Showcase Forset Config Validator


### Showcase CSCC


### Showcase with 1 Policy and fix violation and shows no more violation

TODO: Fix apply pipeline, so end state will be applied

### Showcase Forset Config Validator
Again that the previous violation is no longer there

--- Bad Actor comes in ---
### Edit resource in Cloud Console
Again that the previous violation is no longer there


### Showcase Forset Config Validator
(Force re-run again)
Expect: Location violation
