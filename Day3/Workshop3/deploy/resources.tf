data digitalocean_ssh_key mykey{
    name = "myserverpubkey"
}

locals {
    manifest = jsondecode(file("/home/fred/AIPC/Day3/Workshop3/build/manifest.json"))
    image_id = split(":", local.manifest.builds[length(local.manifest.builds) - 1].artifact_id)[1]
}

resource digitalocean_droplet codeserver {
    name = "codeserver"
    image = local.image_id
    region = var.DO_region
    size = var.DO_size
    ssh_keys = [data.digitalocean_ssh_key.mykey.id]

}

resource local_file inventory{
    filename = "inventory.yaml"
    content = templatefile("inventory.yaml.tftpl", {
        private_key = var.private_key
        codeserver = digitalocean_droplet.codeserver.name
        host = digitalocean_droplet.codeserver.ipv4_address
        domain = "codeserver-${digitalocean_droplet.codeserver.ipv4_address}.nip.io"
        password = "abc123"
    })
    file_permission = "0644"
}

output mydroplet_ipv4_address {
    value = digitalocean_droplet.codeserver.ipv4_address
}
