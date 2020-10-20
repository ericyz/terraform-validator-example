/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  project = var.project_id
}

/******************************************
  Create Bad Buckets (Uncomment to fail the validation)
*******************************************/
# resource "google_storage_bucket" "bad-buckets" {
#   project  = var.project_id
#   location = "asia-southeast1"
#   name     = "bad-bucket-${var.project_id}"

#   labels = {
#     securityzone = "notvalid"
#   }
# }


/******************************************
  Create Good Buckets 
*******************************************/
resource "google_storage_bucket" "good-buckets" {
  project       = var.project_id
  name          = "good-bucket-${var.project_id}"
  storage_class = "REGIONAL"
  location      = "australia-southeast1"

  labels =  {
    integrity       = "uncontrolled"
    confidentiality = "restricted"
    securityzone    = "low"
  }
}