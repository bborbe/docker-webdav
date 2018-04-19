# Webdav

## Run

```
mkdir -p /tmp/webdav
docker run \
-p 8080:80 \
-v /tmp/webdav:/webdav \
bborbe/webdav:latest
```
