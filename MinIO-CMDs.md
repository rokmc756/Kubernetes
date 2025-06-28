
## Configure MinIO Client
```sh
$ /usr/local/bin/mc --insecure config host add minio http://minio-s3.jtest.pivotal.io:9000 jomoon changeme
$ mc alias set myminio http://minio-s3.jtest.pivotal.io:9000 jomoon changeme
```

## Create Bucket
```sh
$ mc mb myminio/jtest-bucket02
```

## Upload File to Bucket
```sh
mc cp /root/ollama-linux-amd64.tgz myminio/jtest-bucket02
```

## Check File is Uploaded
```sh
mc ls myminio/jtest-bucket02
```

## Check Erasure Set
```sh
$ mc admin info myminio
```

## Check Metadata in MinIO Pod
```sh
$ kubectl -n minio exec -it pod/minio-0 -- /bin/sh
> ls -al /export/jtest-bucket01
> cat /export/jtest-bucket01/Weka-DDP-WP-W01R1WP202009.pdf/xl.meta
```


