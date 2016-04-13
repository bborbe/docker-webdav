default: build

clean:
	docker rmi bborbe/webdav

build:
	docker build --no-cache --rm=true -t bborbe/webdav .

run:
	docker run -h example.com bborbe/webdav:latest

shell:
	docker run -i -t bborbe/webdav:latest /bin/bash

upload:
	docker push bborbe/webdav
