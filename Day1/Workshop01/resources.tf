data docker_image dovbear {
  name  = "chukmunnlee/dov-bear:v2"
}


resource docker_container dovbear_container {
    count = var.Num_Of_Nodes
    name = "dov-${count.index}"
    image = data.docker_image.dovbear.id
    env = [
        "INSTANCE_NAME=dov-${count.index}"
        ]
    ports {
        external = 31000 + count.index
        internal = 3000
    }
}

locals {
    ports = [ for p in docker_container.dovbear_container[*].ports: p[0].external]
}
output dovbear_ports {
    value = local.ports
}

/* nGinx ------------------------------------------------------------------------------------------*/

data digitalocean_ssh_key myserverpubkey{
    name = "myserverpubkey"
}

resource local_file nginx_conf{
    filename = "nginx.conf"
    content = templatefile("nginx.conf.tftpl", {
        docker_host = "188.166.238.90"
        container_ports = local.ports
    })
}

resource digitalocean_droplet nginx {
    name = "nginx"
    image = var.DO_image
    region = var.DO_region
    size = var.DO_size
    ssh_keys = [data.digitalocean_ssh_key.myserverpubkey.id]

    connection {
        type = "ssh"
        user = "root"
        private_key = file("~/.ssh/id_rsa")
        host = self.ipv4_address
    }

    provisioner remote-exec{
        inline = [
            "apt update", 
            "apt install -y nginx", 
            "systemctl start nginx", 
            "systemctl enable nginx"
            ]
    }

    provisioner file{
        source = local_file.nginx_conf.filename
        destination = "/etc/nginx/nginx.conf"
    }

    provisioner remote-exec{
        inline = [
            "systemctl restart nginx"
            ]
    }

}

output nginx_ipv4_address {
    value = digitalocean_droplet.nginx.ipv4_address
}
