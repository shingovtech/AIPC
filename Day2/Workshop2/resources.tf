data digitalocean_ssh_key mykey{
    name = "myserverpubkey"
}


resource digitalocean_droplet codeserver {
    name = "codeserver"
    image = var.DO_image
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