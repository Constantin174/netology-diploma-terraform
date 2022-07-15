resource "local_file" "inventory" {
  content = <<-DOC
---
  reverse_proxy:
    hosts:
      studywebservice.ru.yc:
        ansible_host: ${yandex_compute_instance.studywebserviceru.network_interface.0.nat_ip_address}
        ansible_user: ubuntu
        ansible_connection: ssh

    DOC
  filename = "../netology-diploma-ansible/inventory/${terraform.workspace}.yml"

  depends_on = [
    yandex_compute_instance.studywebserviceru
  ]
}
