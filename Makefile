IMAGE_VERSION=2024_01_30

all:
	podman build --jobs 0 --pull --rm -f "Dockerfile" -t us-docker.pkg.dev/jarvice/images/centos-desktop:7-$(IMAGE_VERSION) "."

push: all
	podman push us-docker.pkg.dev/jarvice/images/centos-desktop:7-$(IMAGE_VERSION)
