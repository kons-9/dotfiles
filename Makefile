.PHONY: docker_build_ubuntu docker_run_ubuntu docker_build_fedora
init-zsh:
	zsh shell/zsh/initialize.zsh

init-bash:
	bash shell/bash/initialize.bash

font-install:
	mkdir -p ${XDG_DATA_HOME}/fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
	unzip JetBrainsMono.zip -d ${XDG_DATA_HOME}/fonts
	rm JetBrainsMono.zip
	fc-cache -f -r

xremap:
	sudo gpasswd -a ${USER} input && \
	echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules && \
	cd keybindings/xremap/systemd && \
	systemctl --user enable ./xremap.service && \
	systemctl --user start xremap.service && \
	systemctl --user status xremap.service

# docker build by Dockerfile.ubuntu
docker_build_ubuntu:
	docker build -t test_ubuntu -f Dockerfile.ubuntu .

docker_run_ubuntu: docker_build_ubuntu
	docker run -it --rm test_ubuntu

docker_build_fedora:
	docker build -t test_fedora -f Dockerfile.fedora .
