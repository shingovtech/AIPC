data digitalocean_ssh_key mykey{
    name = "myserverpubkey"
}

data docker_image fortune {
  name  = "chukmunnlee/fortune:v2"
}

/*
resource docker_container fortune_container {
    name = "fortune"
    image = data.docker_image.fortune.id
    ports {
        external = 30000
        internal = 3000
    }
}
*/

resource digitalocean_droplet mydroplet {
    name = "mydroplet"
    image = var.DO_image
    region = var.DO_region
    size = var.DO_size
    ssh_keys = [data.digitalocean_ssh_key.mykey.id]
}
output mydroplet_ipv4_address {
    value = resource.digitalocean_droplet.mydroplet.ipv4_address
}
output mykey_fingerprint {
    description = "my ssh key fingerprint"
    value = data.digitalocean_ssh_key.mykey.fingerprint
}
output fortune_digest {
    description = "fortune digest"
    value = data.docker_image.fortune.repo_digest
}