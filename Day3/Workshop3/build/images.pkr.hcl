variable DO_token{
    type = string
    sensitive = true
}

variable DO_image {
    type = string
    default = "ubuntu-20-04-x64"
}

variable DO_size{
    type = string
    default = "s-1vcpu-2gb"
}

variable DO_region{
    type = string
    default = "sgp1"
}

variable cs_version{
    type = string
}

source digitalocean codeserver{
    api_token = var.DO_token
    region = var.DO_region
    image = var.DO_image
    size = var.DO_size
    snapshot_name = "codeserver-${var.cs_version}"
    ssh_username = "root"
}

build {
    sources = [
        "source.digitalocean.codeserver"
    ]
    provisioner ansible {
        playbook_file = "playbook.yaml"
        extra_arguments = [
            "-e",
            "cs_version=${var.cs_version}"
        ]
    }
    post-processor "manifest" {
        output = "manifest.json"
        strip_path = true
    }
}