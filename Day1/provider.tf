terraform {
    required_version = ">= 1.3"
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
    token = "dop_v1_d9594f3d211d37b677266530231405a6536181f252445305f2cdf157ef46c246"
}
provider local {}