terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "${file("/ya/key.json")}"
  cloud_id  = "b1g6n29jkok2srs36sqc"
  folder_id = "b1g6lkkjagvcniim0l5h"
  zone      = "ru-central1-b"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-1" {
  name = "vm-1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/var/lib/jenkins/.ssh/build_key.pub")}"
  }

}


resource "yandex_compute_instance" "vm-2" {
  name = "vm-2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/var/lib/jenkins/.ssh/build_key.pub")}"
  }

}

resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}

 scheduling_policy {
    preemptible = true
  }


  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/var/lib/jenkins/.ssh/build_key")
    host = self.network_interface[0].nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt install python -y"
    ]
  }

  provisioner "local-exec" {
    command = "echo > /tmp/test1 && echo '[build]' > /tmp/test1 && echo ${self.network_interface[0].nat_ip_address} >> /tmp/test1"
  }
}
