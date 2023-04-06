generate-sbom: ### Run SBOM generator - mandatory: SCHEME=[file|directory|image|registry]; optional: ARGS=[syft args]
	docker run --interactive --tty --rm \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--workdir /project \
		anchore/syft:latest $(SCHEME) $(ARGS)

scan-vulnerabilities: ### Run vulnerability scanner - mandatory: SCHEME=[sbom|file|directory|image|registry]; optional: ARGS=[grype args]
	docker run --interactive --tty --rm \
		--volume /tmp/grype/db:/tmp/grype/db \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--env "XDG_CACHE_HOME=/tmp/grype/db" \
		--workdir /project \
		anchore/grype:latest $(SCHEME) $(ARGS)

.SILENT: \
	generate-sbom \
	scan-vulnerabilities
