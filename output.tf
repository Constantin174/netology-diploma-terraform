output "internal_ip_address_studywebserviceru_yandex_cloud" {
  value = yandex_compute_instance.studywebserviceru.network_interface.0.ip_address
}

output "external_ip_address_studywebserviceru_yandex_cloud" {
  value = yandex_compute_instance.studywebserviceru.network_interface.0.nat_ip_address
}

output "internal_ip_address_dbstudywebserviceru_yandex_cloud" {
  value = [for item in yandex_compute_instance.dbstudywebserviceru : item.network_interface.0.ip_address]
}

output "external_ip_address_dbstudywebserviceru_yandex_cloud" {
  value = [for item in yandex_compute_instance.dbstudywebserviceru : item.network_interface.0.nat_ip_address]
}
