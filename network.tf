# Network
resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name = "subnet_a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.101.0/24"]
}

resource "yandex_vpc_subnet" "subnet_b" {
  name = "subnet_b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.54.0/24"]
}
