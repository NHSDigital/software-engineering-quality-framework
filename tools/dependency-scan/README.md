# Dependency Scan

## Problem

The dependency scan feature can automatically find security vulnerabilities in your dependencies while you are developing and testing your applications. For example, dependency scanning lets you know if your application uses an external (open source) library that is known to be vulnerable. You can then take action to protect your application.

## Solution

TODO: Recipe 1a: Docker images as targets

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

# scan a sbom
grype sbom:./alpine-sbom.json

```
TODO: Recipe 1b: Filesystem
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

TODO: Recipe 2: Using Docker images, Makefile and shell scripting

TODO: Recipe 3: Using GitHub workflow action

## How It Works

TODO: more details on how syft and grype work

- SBOM standards [SPDX](https://spdx.dev/) and [CycloneDX](https://cyclonedx.org/)

## Further Comments

TODO: What's next
