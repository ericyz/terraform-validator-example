FROM gcr.io/cloud-builders/gcloud

RUN curl -O https://storage.googleapis.com/terraform-validator/releases/2019-06-11/terraform-validator-linux-amd64

RUN chmod +x terraform-validator-linux-amd64

RUN mv terraform-validator-linux-amd64 /usr/bin/terraform-validator

ENTRYPOINT ["/usr/bin/terraform-validator"]