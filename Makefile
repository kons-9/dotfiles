.PHONY: docker_build_ubuntu docker_run_ubuntu docker_build_fedora init test sudo-xremap xremap reload-nix

reload-nix:
	cd nix && \
	nix run .#homeConfigurations.default.activationPackage

init: reload-nix
	make sudo-xremap
	
init-wsl: reload-nix

test:
	echo "This is a test target"
	make docker_build_ubuntu

sudo-xremap:
	cd ${XDG_CONFIG_HOME}/systemd/user/ && \
	(sudo systemctl disable xremap.service || true) && \
	sudo systemctl enable ./xremap.service && \
	sudo systemctl start xremap.service && \
	sudo systemctl status xremap.service

xremap:
	sudo gpasswd -a ${USER} input && \
	echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules && \
	cd ${XDG_CONFIG_HOME}/systemd/user/ && \
	(systemctl --user disable xremap.service || true) && \
	systemctl --user enable ./xremap.service && \
	systemctl --user start xremap.service && \
	systemctl --user status xremap.service

# docker build by Dockerfile.ubuntu
docker_build_ubuntu:
	docker build -t test_ubuntu -f test/Dockerfile.ubuntu .

docker_run_ubuntu: docker_build_ubuntu
	docker run -it --rm test_ubuntu

docker_build_fedora:
	docker build -t test_fedora -f test/Dockerfile.fedora .
