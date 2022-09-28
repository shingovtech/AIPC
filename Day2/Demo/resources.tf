data digitalocean_ssh_key mykey{
    name = "myserverpubkey"
}


resource digitalocean_droplet mydroplet {
    name = "mydroplet"
    image = var.DO_image
    region = var.DO_region
    size = var.DO_size
    ssh_keys = [data.digitalocean_ssh_key.mykey.id]

}
output mydroplet_ipv4_address {
    value = digitalocean_droplet.mydroplet.ipv4_address
}