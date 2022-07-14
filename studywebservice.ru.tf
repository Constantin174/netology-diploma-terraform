resource "yandex_compute_instance" "studywebserviceru" {
  name       = "studywebserviceru"
  zone       = local.zone_map[terraform.workspace]
  hostname   = "studywebservice.ru.netology.cloud"

  resources {
    cores    = 2
    memory   = 2
  }

  boot_disk {
    initialize_params {
      image_id    = local.image_id_map[terraform.workspace].id
      name        = "root-node01"
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
