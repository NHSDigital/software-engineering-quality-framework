generate-sbom: ### Run SBOM generator - mandatory: SCHEME=[file|directory|image|registry]; optional: ARGS=[syft args]
	docker run --interactive --tty --rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume $(HOME)/.docker/config.json:/config/config.json \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--workdir /project \
		anchore/syft:latest $(SCHEME) $(ARGS)

scan-vulnerabilities: ### Run vulnerability scanner - mandatory: SCHEME=[sbom|file|directory|image|registry]; optional: ARGS=[grype args]
	docker run --interactive --tty --rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume /tmp/grype/db:/tmp/grype/db \
		--volume $(HOME)/.docker/config.json:/config/config.json \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--env "XDG_CACHE_HOME=/tmp/grype/db" \
		--workdir /project \
		anchore/grype:latest $(SCHEME) $(ARGS)

.SILENT: \
	generate-sbom \
	scan-vulnerabilities
