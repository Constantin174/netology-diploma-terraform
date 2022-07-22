resource "local_file" "mysql_slave" {

  content = <<-DOC
---
db_user: wordpress
db_pass: wordpress

db_name: wordpress

rep_user: rep_user
rep_pass: rep_pass

master_host: ${local.db_names[1]}
    DOC
  filename = "../netology-diploma-ansible/roles/mysql_slave/defaults/main.yml"

  depends_on = [
    yandex_compute_instance.dbstudywebserviceru
  ]
}

