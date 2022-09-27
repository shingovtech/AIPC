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
    token = "dop_v1_b8ca60ef9ca80d755b1b30d06c27cc07d8fa4b63966f112a45c4b6aeaaceef92"
}
provider local {}