data digitalocean_ssh_key mykey{
    name = "mypcpubkey"
}

data docker_image fortune {
  name  = "chukmunnlee/fortune:v2"
}

resource docker_container fortune_container {
    name = "fortune"
    image = data.docker_image.fortune.id
    ports {
        external = 30000
        internal = 3000
    }
}

output mykey_fingerprint {
    description = "my ssh key fingerprint"
    value = data.digitalocean_ssh_key.mykey.fingerprint
}
output fortune_digest {
    description = "fortune digest"
    value = data.docker_image.fortune.repo_digest
}