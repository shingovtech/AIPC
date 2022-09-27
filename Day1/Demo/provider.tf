terraform {

    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.22.0"
        }

        digitalocean = {
            source = "digitalocean/digitalocean"
            version = "2.22.3"
        }

        local = {
            source = "hashicorp/local"
            version = "2.2.3"
        }
    }
}

provider docker {
    host = "unix:///var/run/docker.sock"
}

provider "digitalocean" {
    token = "dop_v1_19c338c985cb5f4283099235c740a716f956e7e84e3a9a0d6046a95668122877"
}
provider local {}