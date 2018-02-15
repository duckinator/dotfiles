TARGET ?= main

all:
	@echo "Usage: make TARGET"
	@echo
	@echo "Where TARGET is the basename of the YAML file."
	@echo "e.g., 'make freebsd-desktop' uses freebsd-desktop.yml."

%:
	TARGET=$@ $(MAKE) run

run:
	ansible --version
	ansible-playbook -i hosts ${TARGET}.yml
