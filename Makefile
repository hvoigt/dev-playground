install-cfssl:
	make -C cfssl
	make -C cfssl install

.PHONY: kubernetes
kubernetes:
	make -C kubernetes quick-release
