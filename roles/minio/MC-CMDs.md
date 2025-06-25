
### Config MC
```bash
/usr/local/bin/mc --insecure config host add minio http://minio-s3.jtest.pivotal.io:9000 jomoon changeme
```


### Create bucket
```bash
mc mb my-minio/jbucet01
```


### Upload Files to Bucket
```bash
$ mc cp /root/ollama-linux-amd64.tgz my-minio/jbucet01
```

### Download Files From Bucket
```bash
$ mc cp my-minio/jbucet01/ollama-linux-amd64.tgz /tmp/
```

