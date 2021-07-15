terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.13.1"
    }
  }
}

provider "grafana" {
  url  = "http://grafana.local/"
  auth = var.grafana_auth
}
