### Rook Storage Architecture
Ceph is a highly scalable distributed storage solution for block storage, object storage, and shared filesystems with years of production deployments.

#### Design
Rook enables Ceph storage to run on Kubernetes using Kubernetes primitives. With Ceph running in the Kubernetes cluster, Kubernetes applications can mount block devices and filesystems managed by Rook, or can use the S3/Swift API for object storage. The Rook operator automates configuration of storage components and monitors the cluster to ensure the storage remains available and healthy.
The Rook operator is a simple container that has all that is needed to bootstrap and monitor the storage cluster. The operator will start and monitor Ceph monitor pods, the Ceph OSD daemons to provide RADOS storage, as well as start and manage other Ceph daemons. The operator manages CRDs for pools, object stores (S3/Swift), and filesystems by initializing the pods and other resources necessary to run the services.
The operator will monitor the storage daemons to ensure the cluster is healthy. Ceph mons will be started or failed over when necessary, and other adjustments are made as the cluster grows or shrinks. The operator will also watch for desired state changes specified in the Ceph custom resources (CRs) and apply the changes.
Rook automatically configures the Ceph-CSI driver to mount the storage to your pods. The rook/ceph image includes all necessary tools to manage the cluster. Rook is not in the Ceph data path. Many of the Ceph concepts like placement groups and crush maps are hidden so you don't have to worry about them. Instead, Rook creates a simplified user experience for admins that is in terms of physical resources, pools, volumes, filesystems, and buckets. Advanced configuration can be applied when needed with the Ceph tools.
Rook is implemented in golang. Ceph is implemented in C++ where the data path is highly optimized. We believe this combination offers the best of both world

#### Architecture
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/rook/files/Rook-High-Level-Architecture.png)


### Prerequiests
* OSD need jumbo frame with MTU 9000
* Kubernetes Network should be with jumbo frame with MTU 9000


### Supported Kubernetes Version
* Kubernetes 1.28.x or later versions


### Configure variables for Rook Ceph and location which will be installed as well as other parameters
```bash
$ vi roles/rook/vars/main.yml

base_path: /root
_rook:
  install: true
  major_version: 1
  minor_version: 15
  patch_version: 5
  # minor_version: 14
  # patch_version: 4
  build_version:
  enable_discovery_daemon: false
  clone_git: true
  nvme: true
  namespace: rook-ceph
  storage_path: "/opt/rook-storage"
  storage_class: "rook-storage"
  lb:
    ip_addr: "192.168.1.219"
  k8s:
    major_version: 1
    minor_version: 28
    patch_version: 0
    build_version:
  hostname: "rook.jtest.pivotal.io"
  service:
    metadata:
      name: rook-loadbalancer
      namespace: rook
  ingress:
    metadata:
      name: rook-ingress
      namespace: nginx-ingress
    hostname: "rook.jtest.pivotal.io"
  kernel_parameters:
    - "net.ipv4.neigh.default.gc_thresh1 = 0"       # For ARP Cache

_helm:
  enable_repo: true
  major_version: 3
  minor_version:
  patch_version:
  build_version:


_cm:
  install: false
  namespace: cert-manager
  major_version: 1
  minor_version: 7
  patch_version: 1


_nginx:
  ingress:
    install: true
    name: nginx-ingress
    class_name: rook-ingress-class
    namespace: "nginx-ingress"
    major_version:
    minor_version:
    patch_version:
    hostname: rook
    domain: jtest.pivotal.io
    ip_addr: "192.168.1.219"
    replica: 1
  k8s_ingress:
    major_version: 3
    minor_version: 0
    patch_version: 2
```

### How to Deploy Rook Ceph
```bash
$ make rook r=apply s=param
$ make rook r=enable s=repo
$ make rook r=deploy s=ceph
$ make rook r=setup s=cm ( optional )
$ make rook r=setup s=ingress
$ make rook r=setup s=lb
$ make rook r=change s=password

or
$ make rook r=install s=all
```

### How to Destroy Rook Ceph
```bash
$ make rook r=delete s=lb
$ make rook r=delete s=ingress
$ make rook r=delete s=cm ( optional )
$ make rook r=delete s=ceph
$ make rook r=disable s=repo
$ make rook r=remove s=param

or
$ make rook r=uninstall s=all
```
