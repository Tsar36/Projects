terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

# Provider Configuration
provider "google" {
  project = "your-gcp-project-id" # Замените на ваш реальный Project ID
  region  = "europe-west1"        # Или europe-southwest1
}

# Variables
variable "region" {
  default = "europe-west1" # Или europe-southwest1
}

# VPC Network
resource "google_compute_network" "vpc" {
  name = "vpc-network"
}

# Firewall Rules
resource "google_compute_firewall" "allow-http-https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["web"]
}

# Managed Instance Template for Frontend
resource "google_compute_instance_template" "frontend_template" {
  name         = "frontend-template"
  machine_type = "e2-micro"

  disk {
    boot       = true
    auto_delete = true
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc.self_link
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Frontend Instance" > /var/www/html/index.html
    systemctl start nginx
  EOT

  tags = ["web"]
}

# Managed Instance Group for Frontend
resource "google_compute_instance_group_manager" "frontend_group" {
  name               = "frontend-group"
  base_instance_name = "frontend"
  instance_template  = google_compute_instance_template.frontend_template.self_link
  target_size        = 2
  zone               = "europe-west1-b" # Или europe-southwest1-a
}

# Backend Service for Load Balancer
resource "google_compute_backend_service" "frontend_backend_service" {
  name          = "frontend-backend-service"
  health_checks = [google_compute_health_check.http_health_check.self_link]

  backend {
    group = google_compute_instance_group_manager.frontend_group.instance_group
  }
}

# HTTP Health Check
resource "google_compute_health_check" "http_health_check" {
  name = "http-health-check"

  http_health_check {
    request_path = "/"
    port         = 80
  }
}

# HTTP Load Balancer
resource "google_compute_global_address" "lb_ip" {
  name = "frontend-lb-ip"
}

resource "google_compute_url_map" "url_map" {
  name            = "frontend-url-map"
  default_service = google_compute_backend_service.frontend_backend_service.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  ip_address = google_compute_global_address.lb_ip.address
  port_range = "80"
  target     = google_compute_target_http_proxy.http_proxy.self_link
}

# DNS Zone and A Record
resource "google_dns_managed_zone" "dns_zone" {
  name     = "example-zone"
  dns_name = "example.com."
}

resource "google_dns_record_set" "a_record" {
  managed_zone = google_dns_managed_zone.dns_zone.name
  name         = "app.example.com."
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_global_address.lb_ip.address]
}

# Logging and Monitoring
resource "google_logging_project_sink" "log_sink" {
  name        = "log-sink"
  destination = "logging.googleapis.com"
  filter      = "resource.type=\"gce_instance\""
}

resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Admin Email"
  type         = "email"
  labels = {
    email_address = "admin@example.com"
  }
}

resource "google_monitoring_alert_policy" "cpu_alert" {
  display_name          = "High CPU Usage"
  notification_channels = [google_monitoring_notification_channel.email_channel.name]

  conditions {
    display_name = "CPU Usage Condition"
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      duration        = "120s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  combiner = "OR"
  enabled  = true
}