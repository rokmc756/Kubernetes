# Download DirectPV plugin.
$ release=$(curl -sfL "https://api.github.com/repos/minio/directpv/releases/latest" | awk '/tag_name/ { print substr($2, 3, length($2)-4) }')
$ curl -fLo kubectl-directpv https://github.com/minio/directpv/releases/download/v${release}/kubectl-directpv_${release}_linux_amd64
# Make the binary executable.
$ chmod a+x kubectl-directpv
$ mv kubectl-directpv /usr/local/bin/kubectl-directpv

