VERSION ?= 1.0.0

default: build

clean:
	docker rmi bborbe/webdav:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t bborbe/webdav:$(VERSION) .

run:
	mkdir -p /tmp/webdav
	docker run -h example.com -p 80:80 -v /tmp/webdav:/webdav bborbe/webdav:$(VERSION)

shell:
	docker run -i -t bborbe/webdav:$(VERSION) /bin/bash

upload:
	docker push bborbe/webdav:$(VERSION)
