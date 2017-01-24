#!/bin/sh

set -e

tag=$(git tag -l --points-at HEAD)

if ! test -z "$tag"; then
	VERSION=${tag} make build
	VERSION=${tag} make upload
	VERSION=${tag} make clean
fi

VERSION=latest make build
VERSION=latest make upload
VERSION=latest make clean
