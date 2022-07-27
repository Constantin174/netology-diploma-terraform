resource "local_file" "prometheus_config" {

  content = <<-DOC
---
global:
  scrape_interval:     15s
  evaluation_interval: 15s

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
      monitor: 'prometheus'

# Load and evaluate rules in this file every 'evaluation_interval' seconds.
rule_files:
  - "alert.rules"

# A scrape configuration containing exactly one endpoint to scrape.
scrape_configs:
  - job_name: 'reverse_proxy'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.studywebserviceru.network_interface.0.nat_ip_address}:9100']
      
  - job_name: 'db1'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.dbstudywebserviceru[1].network_interface.0.nat_ip_address}:9100']
      
  - job_name: 'db2'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.dbstudywebserviceru[2].network_interface.0.nat_ip_address}:9100']
      
  - job_name: 'wordpress'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.appstudywebserviceru.network_interface.0.nat_ip_address}:9100']
      
  - job_name: 'gitlab'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.gitlabstudywebserviceru.network_interface.0.nat_ip_address}:9100']
      
  - job_name: 'gitlab-runner'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.runnerstudywebserviceru.network_interface.0.nat_ip_address}:9100']
      
  - job_name: 'monitoring'
    scrape_interval: 5s
    static_configs:
      - targets: ['${yandex_compute_instance.monitoringstudywebserviceru.network_interface.0.nat_ip_address}:9100']

  - job_name: 'prometheus'
    scrape_interval: 10s
    static_configs:
      - targets: ['${yandex_compute_instance.monitoringstudywebserviceru.network_interface.0.nat_ip_address}:9090']

  - job_name: 'alertmanager'
    scrape_interval: 10s
    honor_labels: true
    static_configs:
      - targets: ['${yandex_compute_instance.monitoringstudywebserviceru.network_interface.0.nat_ip_address}:9093']

  - job_name: 'grafana'
    scrape_interval: 10s
    honor_labels: true
    static_configs:
      - targets: ['${yandex_compute_instance.monitoringstudywebserviceru.network_interface.0.nat_ip_address}:3000']


alerting:
  alertmanagers:
  - scheme: http
    static_configs:
    - targets:
      - '${yandex_compute_instance.monitoringstudywebserviceru.network_interface.0.nat_ip_address}:9093'
    DOC
  filename = "../netology-diploma-ansible/roles/monitoring/files/prometheus/prometheus.yml"

  depends_on = [
    yandex_compute_instance.studywebserviceru,
    yandex_compute_instance.dbstudywebserviceru[1],
    yandex_compute_instance.dbstudywebserviceru[2],
    yandex_compute_instance.appstudywebserviceru,
    yandex_compute_instance.gitlabstudywebserviceru,
    yandex_compute_instance.runnerstudywebserviceru,
    yandex_compute_instance.monitoringstudywebserviceru
  ]
}

