#!/bin/bash

### Note: just example
# Master
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.2

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get pods -A

# Master: pods network
https://kubernetes.io/docs/concepts/cluster-administration/addons/

- Weave Net
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

kubectl get ds -A

kubectl edit ds weave-net -n kube-system

- add env
- name: IPALLOC_RANNGE
  value: 10.244.0.0/16

# Node
sudo kubeadm join 192.168.56.2:6443 \
--token dm9don.4y83rukzu55xxsnp \
--discovery-token-ca-cert-hash sha256:19a0b6913d8749efda1ce02c1f3eea33f20fd3cbbd8233a4c6c636d704696f4b

sudo kubeadm join 192.168.56.2:6443 --token lywz7l.24gfjm0e7bqhtbox \
        --discovery-token-ca-cert-hash sha256:1477706d77a93bafe54081f2fe9b39f13af12c5ed042c5c510229df04d3b14af

kubectl get nodes