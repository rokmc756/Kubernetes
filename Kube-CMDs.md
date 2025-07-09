

## Print all Internal FDQN in Kubernetes Cluster
```sh
$ kubectl get svc -A -o json | jq -r '.items[] | "\(.metadata.name).\(.metadata.namespace).svc.cluster.local"'
kubernetes.default.svc.cluster.local
grafana-nginx-ingress-ingress-nginx-controller.grafana-nginx-ingress.svc.cluster.local
grafana-nginx-ingress-ingress-nginx-controller-admission.grafana-nginx-ingress.svc.cluster.local
grafana.grafana.svc.cluster.local
kube-dns.kube-system.svc.cluster.local
metallb-webhook-service.metallb-system.svc.cluster.local
minio-api-nginx-ingress-ingress-nginx-controller.minio-nginx-ingress.svc.cluster.local
minio-api-nginx-ingress-ingress-nginx-controller-admission.minio-nginx-ingress.svc.cluster.local
minio-console-nginx-ingress-ingress-nginx-controller.minio-nginx-ingress.svc.cluster.local
minio-console-nginx-ingress-ingress-nginx-controller-admission.minio-nginx-ingress.svc.cluster.local
minio.minio.svc.cluster.local
minio-console.minio.svc.cluster.local
minio-svc.minio.svc.cluster.local
alertmanager-nginx-ingress-ingress-nginx-controller.prometheus-nginx-ingress.svc.cluster.local
alertmanager-nginx-ingress-ingress-nginx-controller-admission.prometheus-nginx-ingress.svc.cluster.local
prometheus-nginx-ingress-ingress-nginx-controller.prometheus-nginx-ingress.svc.cluster.local
prometheus-nginx-ingress-ingress-nginx-controller-admission.prometheus-nginx-ingress.svc.cluster.local
prometheus-alertmanager.prometheus.svc.cluster.local
prometheus-alertmanager-headless.prometheus.svc.cluster.local
prometheus-server.prometheus.svc.cluster.local
prometheus-thanos.prometheus.svc.cluster.local
```

### Print the FQDN of a Pod
```sh
$ kubectl get pods -A -o json | jq -r '.items[] | select(.status.podIP != null) | "\(.status.podIP).\(.metadata.namespace).pod.cluster.local"' | grep minio
10.142.16.74.minio-nginx-ingress.pod.cluster.local
10.142.52.11.minio-nginx-ingress.pod.cluster.local
10.142.83.200.minio.pod.cluster.local
10.142.16.72.minio.pod.cluster.local
10.142.52.9.minio.pod.cluster.local
10.142.83.199.minio.pod.cluster.local
10.142.16.73.minio.pod.cluster.local
10.142.52.10.minio.pod.cluster.local
10.142.136.135.minio.pod.cluster.local
10.142.136.134.minio.pod.cluster.local
```

### How to Check Cluster Domain (e.g., cluster.local)
```sh
$ kubectl get configmap coredns -n kube-system -o yaml | grep cluster.local
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           disable success cluster.local
           disable denial cluster.local
```

* Or view directly
```sh
$ kubectl get configmap coredns -n kube-system -o jsonpath='{.data.Corefile}'
.:53 {
    errors
    health {
       lameduck 5s
    }
    ready
    kubernetes cluster.local in-addr.arpa ip6.arpa {
       pods insecure
       fallthrough in-addr.arpa ip6.arpa
       ttl 30
    }
    prometheus :9153
    forward . /etc/resolv.conf {
       max_concurrent 1000
    }
    cache 30 {
       disable success cluster.local
       disable denial cluster.local
    }
    loop
    reload
    loadbalance
}
```

