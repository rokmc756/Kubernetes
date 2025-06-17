## What is this Repository
The Kubernetees is Ansible Playbook to deploy Native Kubernetes Cluster and deploy bunch of K8S Softwares and Applications on it such as Rancher, Rook Ceph, Postgres, Kubeflow, Kafka and so an.

## Kubernetes Architecutre
![alt text](https://github.com/rokmc756/kubernetes/blob/main/roles/k8s/files/kubernetes_architecture.webp)

## Supported Platform and OS
Virtual Machines\
Baremetal\
RHEL and CentOS 9 and Rocky Linux 9.x\
OpenSUSE 15.x\
Ubuntu 22.x

## Prerequisite for ansible host
MacOS or Windows Linux Subsysetm or Many kind of Linux Distributions should have ansible as ansible host.\
Supported OS for ansible target host should be prepared with package repository configured such as yum, dnf and apt as well as zypper

## Prepare ansible host to run this Ansible Playbook
* MacOS
```bash
$ xcode-select --install
$ brew install ansible
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

* Fedora/CentOS/RHEL, Ubuntu, OpenSUSE
```bash
$ yum install ansible
$ apt install ansible
$ zypper install ansible
```

## How to Deploy and Destroy Kubernetes Cluster
#### 1) Configure Variables and Inventory with Hostnames, IP Addresses, sudo Username and Password
##### Configure Inventory
```ini
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"
ansible_python_interpreter=/usr/bin/python3

[master]
rk9-node01 ansible_ssh_host=192.168.1.171

[master]
rk9-node02 ansible_ssh_host=192.168.1.172

[workers]
rk9-node01 ansible_ssh_host=192.168.1.173
rk9-node02 ansible_ssh_host=192.168.1.174
rk9-node03 ansible_ssh_host=192.168.1.175
rk9-node04 ansible_ssh_host=192.168.1.176
```

##### Configure Variables
```yaml
$ vi roles/hosts/vars/main.yml
ansible_ssh_pass: "changeme"
ansible_become_pass: "changeme"
sudo_user: "kubeadm"
sudo_group: "kubeadm"
local_sudo_user: "jomoon"
wheel_group: "wheel"            # RHEL / CentOS / Rocky / SUSE / OpenSUSE
root_user_pass: "changeme"
sudo_user_pass: "changeme"
sudo_user_home_dir: "/home/{{ sudo_user }}"
domain_name: "jtest.suse.com"
~~ snip
```

##### Configure Global Variables
```yaml
$ vi group_vars/all.yml
ansible_ssh_pass: "changeme"
ansible_become_pass: "changeme"

k8s:
  cluster_name: jack-suse-k8s
  major_version: "1"
  minor_version: "28"               # Rancher does not support higher than kubernetes 1.28.x versions currently
  patch_version: "0"
  build_version: ""
  repo_url: ""
  download_url: ""
  download: false
  base_path: /root
  host_num: "{{ groups['workers'] | length }}"
  net:
    type: "virtual"
    gateway: "192.168.0.1"
    ipaddr0: "192.168.0.17"
    ipaddr1: "192.168.1.17"
    ipaddr2: "192.168.2.17"
~~ snip
  cni:
    name: calico # kube-flannel
    operator: ""
    major_version: 3
    minor_version: 27
    patch_version: 3
    pod_network: "10.142.0.0/16"
~~ snip
```


#### 2) Initialize Linux Hosts to exchanges ssh keys for passwordless login and install neccessary packages as well as configure /etc/hosts file
```bash
$ make hosts r=init s=all
```
[![YouTube](http://i.ytimg.com/vi/mFp3oi2-sb0/hqdefault.jpg)](https://www.youtube.com/watch?v=mFp3oi2-sb0)


#### 3) Deploy Kubernetes Cluster
```bash
$ make k8s r=install s=all
```
[![YouTube](http://i.ytimg.com/vi/ZAYEYPk-NEk/hqdefault.jpg)](https://www.youtube.com/watch?v=ZAYEYPk-NEk)


#### 4) Destroy Kubernetes Cluster
```bash
$ make k8s r=uninstall s=all
```
[![YouTube](http://i.ytimg.com/vi/OW_NdpsjJSg/hqdefault.jpg)](https://www.youtube.com/watch?v=OW_NdpsjJSg)


#### 5) Deploy Rancher
```bash
$ make rancher r=install s=all
```
[![YouTube](http://i.ytimg.com/vi/8a8S0V1Gs4E/hqdefault.jpg)](https://www.youtube.com/watch?v=8a8S0V1Gs4E)


#### 6) Destroy Rancher
```bash
$ make rancher r=uninstall s=all
```
[![YouTube](http://i.ytimg.com/vi/QTmhB9awxY8/hqdefault.jpg)](https://www.youtube.com/watch?v=QTmhB9awxY8)


#### 7) Deploy Rook Ceph
```bash
$ make rook r=install s=all
```
[![YouTube](http://i.ytimg.com/vi/fw0qFdploNQ/hqdefault.jpg)](https://www.youtube.com/watch?v=fw0qFdploNQ)


#### 8) Destroy Rook Ceph
```bash
$ make rook r=uninstall s=all
```

#### 9) Deploy Open WebUI for Deepseek R1
```bash
$ make deepseek r=install s=all
```
[![YouTube](https://github.com/rokmc756/Kubernetes/blob/main/roles/deepseek/images/01-deploy-deepseek.jpg)](https://youtu.be/Ze9baCb9QQs?si=jfRT1uSyX7DcJI6F)


#### 10) Destroy Open WebUI for Deepseek R1
```bash
$ make deepseek r=uninstall s=all
```

### 11) Configure Open WebUI for DeepSeek R1 Model
[![YouTube](https://github.com/rokmc756/Kubernetes/blob/main/roles/deepseek/images/02-config-open-webui.jpg))](https://www.youtube.com/watch?v=jSCiGs7OCFg)


### 12) Reinitialize Kubernetes Cluster
The make reinit will reinitialize k8s cluster referring reinit.yml playbook if you are struggle the uncertain situation such as stuck or panic
```bash
$ make k8s r=reinit s=all
```


## References
* https://k21academy.com/docker-kubernetes/multi-node-kubernetes-cluster-on-suse-linux/
* https://tuanpembual.wordpress.com/2020/10/15/run-opensuse-kubic-like-k8s-podman-cri-o-on-alibaba-cloud/
* https://github.com/rokmc756/kubernetes/blob/main/roles/k8s/files/kubernetes-cluster-architecture.svg
* https://medium.com/@muppedaanvesh/deploying-nginx-on-kubernetes-a-quick-guide-04d533414967
* https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/
* https://aws.plainenglish.io/how-to-deploy-a-nginx-server-with-kubernetes-9228f17e399c
* https://medium.com/@sumuduliyan/kubernetes-networking-with-calico-623f4583ae8d
* https://stackoverflow.com/questions/62795930/how-to-install-kubernetes-in-suse-linux-enterprize-server-15-virtual-machines


## Similar Playbook
* https://gist.github.com/allanger/84db2647578316f8e721f7219052788f
* https://spacelift.io/blog/ansible-kubernetes


## TODO
* Fixing interaction with harbor
* Deploy VMware-Postgres and MySQL
* Multi Master
- https://github.com/hub-kubernetes/kubeadm-multi-master-setup
- https://www.useoflinux.com/install-and-configure-a-multi-master-kubernetes-cluster-with-kubeadm/
- https://navyadevops.hashnode.dev/kubernetes-multi-master-setup-with-loadbalancer-on-ubuntu
- https://www.lisenet.com/2021/install-and-configure-a-multi-master-ha-kubernetes-cluster-with-kubeadm-haproxy-and-keepalived-on-centos-7/
- https://www.redhat.com/sysadmin/ansible-playbooks-secrets ( Password Envription in Ansible Playbook with Vault )


## Debugging
* DNS - https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
* Network - https://yandex.cloud/en/docs/managed-kubernetes/operations/calico?utm_referrer=https%3A%2F%2Fwww.google.com%2F

