# Grafana K8s Pod

This setup creates a Grafana pod, which uses a local directory, `/var/lib/grafana`, on the target node for
persistent data, and listens on port 3000. I've got a `NodePort` service set up to map that port to port 30000 on
the external IP address.
