locals {
    server_names = {
        1 = "db01"
        2 = "db02"
    }
}

resource "yandex_compute_instance" "dbstudywebserviceru" {
  for_each = local.server_names

  name       = "${each.value}studywebserviceru"
  zone       = local.zone_map[terraform.workspace]
  hostname   = "${each.value}.studywebservice.ru.yc"

  resources {
    cores    = 4
    memory   = 4
  }

  boot_disk {
    initialize_params {
      image_id    = local.image_id_map[terraform.workspace].id
      name        = "root-node-${each.value}"
      type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = local.subnet_map[terraform.workspace].id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
