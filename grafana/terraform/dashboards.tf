resource "grafana_dashboard" "media-server" {
  config_json = file("media-server.json")
}
