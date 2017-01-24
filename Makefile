VERSION ?= latest
REGISTRY ?= docker.io

default: build

clean:
	docker rmi $(REGISTRY)/bborbe/webdav:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t $(REGISTRY)/bborbe/webdav:$(VERSION) .

run:
	mkdir -p /tmp/webdav
	docker run \
	-p 8080:80 \
	-v /tmp/webdav:/webdav \
	$(REGISTRY)/bborbe/webdav:$(VERSION)

shell:
	docker run -i -t $(REGISTRY)/bborbe/webdav:$(VERSION) /bin/bash

upload:
	docker push $(REGISTRY)/bborbe/webdav:$(VERSION)
