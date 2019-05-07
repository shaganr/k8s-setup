#!/bin/bash

echo "Script written to work on Ubuntu 16.04"
sleep 3
echo
echo "Disable swap until next reboot"
echo 
sudo swapoff -a

echo "Update the local node"
sudo apt-get update && sudo apt-get upgrade -y
echo
echo "Install Docker"
sleep 3

sudo apt-get install -y docker.io
echo
echo "Install kubeadm and kubectl"
sleep 3

sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

sudo apt-get update

sudo apt-get install -y kubeadm=1.13.1-00 kubelet=1.13.1-00 kubectl=1.13.1-00

echo
echo "Installed - now to get Calico Project network plugin"

sleep 3

sudo kubeadm init --kubernetes-version 1.13.1 --pod-network-cidr 192.168.0.0/16

sleep 5

echo "Running the steps shown above ^^ "

mkdir -p $HOME/.kube

sleep 2

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sleep 2

sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Download Calico plugin and RBAC YAML files and apply"

wget https://tinyurl.com/yb4xturm -O rbac-kdd.yaml

wget https://tinyurl.com/y8lvqc9g  -O calico.yaml

kubectl apply -f rbac-kdd.yaml

kubectl apply -f calico.yaml

echo
echo
sleep 3
echo "You should see this node in the output below"
echo
kubectl get node
echo
echo
echo "Finished, connect other node."



