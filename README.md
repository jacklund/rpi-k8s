# Raspberry Pi Kubernetes Cluster

My project to put together a Kubernetes cluster using Raspberry Pis.

My current configuration is a single Raspberry Pi 4 as controller, and two Raspberry Pi 3's as workers.

Setup instructions are [here](setup.md).

Once done, set up your ansible inventory with groups `kube_controllers` and `kube_workers`, and run the ansible scripts in the `ansible` directory.

## Running kubectl Remotely

Copy the `$HOME/.kube/config` file from your k8s controller to your local machine. In my case:

```
% mkdir ~/.kube
% scp k8s-controller01.local:.kube/config ~/.kube
```
