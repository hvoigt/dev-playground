install-cfssl:
	make -C cfssl
	make -C cfssl install

.PHONY: kubernetes
kubernetes:
	make -C kubernetes

images:
	./scripts/build-images.sh

.PHONY: ca
ca:
	make -C ca
