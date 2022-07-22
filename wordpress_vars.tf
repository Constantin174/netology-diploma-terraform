resource "local_file" "wordpress" {

  content = <<-DOC
---
mysql_db: "wordpress"
mysql_user: "wordpress"
mysql_password: "wordpress"

http_host: "appstudywebserviceru"
http_conf: "appstudywebserviceru.conf"

db_host: ${local.db_names[1]}
    DOC
  filename = "../netology-diploma-ansible/roles/wordpress/defaults/main.yml"

  depends_on = [
    yandex_compute_instance.appstudywebserviceru
  ]
}

