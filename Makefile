.PHONY: docker_build_ubuntu docker_run_ubuntu docker_build_fedora
# docker build by Dockerfile.ubuntu
docker_build_ubuntu:
	docker build -t test_ubuntu -f Dockerfile.ubuntu .

docker_run_ubuntu: docker_build_ubuntu
	docker run -it --rm test_ubuntu

docker_build_fedora:
	docker build -t test_fedora -f Dockerfile.fedora .
