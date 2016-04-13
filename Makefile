default: build

clean:
	docker rmi bborbe/webdav

build:
	docker build --no-cache --rm=true -t bborbe/webdav .

run:
	mkdir -p /tmp/webdav
	docker run -h example.com -p 80:80 -v /tmp/webdav:/webdav bborbe/webdav:latest

shell:
	docker run -i -t bborbe/webdav:latest /bin/bash

upload:
	docker push bborbe/webdav
