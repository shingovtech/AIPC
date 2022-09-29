terraform {

    required_providers {

        digitalocean = {
            source = "digitalocean/digitalocean"
            version = "2.22.3"
        }

        local = {
            source = "hashicorp/local"
            version = "2.2.3"
        }
    }

    backend s3 {
        skip_credentials_validation = true
        skip_metadata_api_check = true
        skip_region_validation = true
        endpoint = "sgp1.digitaloceanspaces.com"
        key = "states/terraform.tfstate"

    }
}

provider "digitalocean" {
    token = var.DO_token
}
provider local {}