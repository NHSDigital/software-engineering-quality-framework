# Dependency Scan

## Problem

The dependency scan feature can automatically find security vulnerabilities in your dependencies while you are developing and testing your applications. For example, dependency scanning lets you know if your application uses an external (open source) library that is known to be vulnerable. You can then take action to protect your application.

## Solution

### Syft
A CLI tool and for generating a Software Bill of Materials (SBOM) from container images and filesystems. Provides vulnerability detection when used with a scanner like Grype.

### Grype

A vulnerability scanner for container images and filesystems. Works with Syft, SBOM (software bill of materials) tool for container images and filesystems.

Recipe 1a: Docker images as targets

- [syft](https://github.com/anchore/syft)

### Example usage
```
# catalog a container image archive (from the result of `docker image save ...`, `podman save ...`, or `skopeo copy` commands)
syft path/to/image.tar
```
```
# specify an output format
syft <image> -o <format>
syft <image> -o cyclonedx-json=<file>
```
```
# convert cyclonedx-json to human readable format
cat <file> | jq -r '(["name", "type", "version"] | (.,map(length*"-"))), (.components[] | [.name, .type, .version]) | @tsv ' | column -t
```

- [grype](https://github.com/anchore/grype)

```
# scan a container image archive (from the result of `docker image save ...`, `podman save ...`, or `skopeo copy` commands)
grype path/to/image.tar

# Use SBOM as input to vulnerability scan
grype sbom:./path/to/sbom.json

```
Recipe 1b: Filesystem
- [syft](https://github.com/anchore/syft)

```
# catalog a folder
syft path/to/dir -o cyclonedx-json=<file>
```
- [grype](https://github.com/anchore/grype)
```
# scan a directory
grype dir:path/to/dir
```

Recipe 2: Using Docker images, shell scripting and Makefile

Makefile
```bash
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
		--volume $(HOME)/.docker/config.json:/config/config.json \
		--volume $(PWD):/project \
		--env "DOCKER_CONFIG=/config" \
		--workdir /project \
		anchore/grype:latest $(SCHEME) $(ARGS)

```

Run from a command-line
```bash
$ make generate-sbom SCHEME=alpine:3.11.3 ARGS="-o cyclonedx-json=sbom.cdx.json"
$ make scan-vulnerabilities SCHEME=sbom:./sbom.cdx.json
```

TODO: Recipe 3: Using GitHub workflow action

## How It Works

- Syft generates SBOMs for container images, filesystems & archives to discover packages and libraries
- Supports OCI and Docker image formats
- Linux distribution identification
- Converts between SBOM formats, such as CycloneDX, SPDX, and Syft's own format.
- **[CycloneDX](https://cyclonedx.org/)** is a lightweight SBOM standard useful for application security and supply chain component analysis. CycloneDX is an open source project that originated in the OWASP community.

- **[SPDX](https://spdx.dev/)** is an ISO standard hosted by the Linux Foundation, which outlines the components, licenses, and copyrights associated with a software package.


## Further Comments

TODO: What's next
- Integrate SBOM into CI/CD piplines to provide early visibility of application dependencies.
- Consider where SBOM artifacts are stored, i.e committed and tagged in the source repository.
- Use SBOM to continually scan for new vulnerabilities as they are discovered.
