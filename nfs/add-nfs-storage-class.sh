#! /bin/bash

helm repo add nfs-subdir-external-provisioner \
  https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update
helm install nfs-provisioner \
  nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
  --set nfs.server=k8s-controller01.local \
  --set nfs.path=/mnt/nfs \
  --set storageClass.name=nfs \
  --values nfs/values.yml
