generate-sbom: ### Run SBOM generator - mandatory: IMAGE
	docker run --interactive --tty --rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume $(HOME)/.docker/config.json:/config/config.json \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--workdir /project \
		anchore/syft:latest $(IMAGE)

scan-vulnerabilities: ### Run vulnerability scanner - mandatory: IMAGE
	docker run --interactive --tty --rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume $(HOME)/.docker/config.json:/config/config.json \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--workdir /project \
		anchore/grype:latest $(IMAGE)
