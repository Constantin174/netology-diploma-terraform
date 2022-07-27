locals {
    db_names = {
        1 = yandex_compute_instance.dbstudywebserviceru[1].network_interface.0.nat_ip_address
        2 = yandex_compute_instance.dbstudywebserviceru[2].network_interface.0.nat_ip_address
    }
}

resource "local_file" "inventory_reverse_proxy" {

  content = <<-DOC
---
  reverse_proxy:
    hosts:
      studywebservice.ru.yc:
        ansible_host: ${yandex_compute_instance.studywebserviceru.network_interface.0.nat_ip_address}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}-reverse-proxy.yml"

  depends_on = [
    yandex_compute_instance.studywebserviceru
  ]
}

resource "local_file" "inventory_db" {
  for_each = local.db_names

  content = <<-DOC
---
  db${each.key}:
    hosts:
      db${each.key}studywebservice.ru.yc:
        ansible_host: ${each.value}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}-db${each.key}.yml"

  depends_on = [
    yandex_compute_instance.dbstudywebserviceru
  ]
}

resource "local_file" "inventory_app" {

  content = <<-DOC
---
  app:
    hosts:
      appstudywebservice.ru.yc:
        ansible_host: ${yandex_compute_instance.appstudywebserviceru.network_interface.0.nat_ip_address}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}-app.yml"

  depends_on = [
    yandex_compute_instance.appstudywebserviceru
  ]
}

resource "local_file" "inventory_gitlab" {

  content = <<-DOC
---
  gitlab:
    hosts:
      gitlabstudywebservice.ru.yc:
        ansible_host: ${yandex_compute_instance.gitlabstudywebserviceru.network_interface.0.nat_ip_address}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}-gitlab.yml"

  depends_on = [
    yandex_compute_instance.gitlabstudywebserviceru
  ]
}

resource "local_file" "inventory_runner" {

  content = <<-DOC
---
  runner:
    hosts:
      runnerstudywebservice.ru.yc:
        ansible_host: ${yandex_compute_instance.runnerstudywebserviceru.network_interface.0.nat_ip_address}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}-runner.yml"

  depends_on = [
    yandex_compute_instance.runnerstudywebserviceru
  ]
}

resource "local_file" "inventory_monitoring" {

  content = <<-DOC
---
  monitoring:
    hosts:
      monitoringstudywebserviceru.ru.yc:
        ansible_host: ${yandex_compute_instance.monitoringstudywebserviceru.network_interface.0.nat_ip_address}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}-monitoring.yml"

  depends_on = [
    yandex_compute_instance.monitoringstudywebserviceru
  ]
}
