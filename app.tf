resource "yandex_compute_instance" "appstudywebserviceru" {
  name       = "appstudywebserviceru"
  zone       = local.zone_map[terraform.workspace]
  hostname   = "app.studywebservice.ru.yc"

  resources {
    cores    = 4
    memory   = 4
  }

  boot_disk {
    initialize_params {
      image_id    = local.image_id_map[terraform.workspace].id
      name        = "root-node-app"
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
