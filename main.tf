terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "studywebservice-object-storage"
    region     = "ru-central1-a"
    key        = ".terraform/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

data "yandex_compute_image" "ubuntu-2004" {
    family = "ubuntu-2004-lts"
}

provider "yandex" {
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = var.zone_a
}

locals {
    image_id_map = {
        stage = data.yandex_compute_image.ubuntu-2004
        prod = data.yandex_compute_image.ubuntu-2004
    }
    
    subnet_map = {
        stage = yandex_vpc_subnet.subnet_a
        prod = yandex_vpc_subnet.subnet_b
    }
    
    zone_map = {
        stage = var.zone_a
        prod = var.zone_b
    }
}
