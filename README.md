# Kubernetes (1.13) Bootstrap Script for GCP

---

## About

Sets up 2 node k8s cluster on GCP. Project uses Project Calico so nodes can speak to one another.

## Setup

1. Create 2 nodes on GCP with at least 8Gb of RAM on Ubuntu 16.04 LTS
2. Make sure correct VPC and firewall rules are set to allow nodes to ping one another
3. Run Master script first on one node, second script on the other.
4. Connect the slave node to the master with the command that's stdout (kubeadm join)