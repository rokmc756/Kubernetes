
## Configure MinIO Client
```sh
$ /usr/local/bin/mc --insecure config host add minio http://minio-s3.jtest.pivotal.io:9000 jomoon changeme
$ mcli alias set myminio http://minio-s3.jtest.pivotal.io:9000 jomoon changeme
```

## Create Bucket
```sh
$ mcli mb myminio/jtest-bucket02
```

## Upload File to Bucket
```sh
mcli cp /root/ollama-linux-amd64.tgz myminio/jtest-bucket02
```

## Check File is Uploaded
```sh
mcli ls myminio/jtest-bucket02
```

## Check Erasure Set
```sh
$ mcli admin info myminio
```

## Check Metadata in MinIO Pod
```sh
$ kubectl -n minio exec -it pod/minio-0 -- /bin/sh
> ls -al /export/jtest-bucket01
> cat /export/jtest-bucket01/Weka-DDP-WP-W01R1WP202009.pdf/xl.meta
```

## Warp Benchmark
```sh
/usr/bin/warp mixed --host https://rk9-node0{1...4}.jtest.pivotal.io:9000 --access-key=miioadmin --secret-key=changeme --autoterm

/usr/bin/warp mixed --host https://rk9-node01.jtest.pivotal.io:9000 --access-key=miioadmin --secret-key=changeme --autoterm

/usr/bin/warp --host http://127.0.0.1:9000 --access-key minioadmin --secret-key changeme

/usr/bin/warp mixed --host https://rk9-node01.jtest.pivotal.io:9000 --access-key minioadmin --secret-key changeme --duration 1m --objects 1000 --concurrent 16

```

