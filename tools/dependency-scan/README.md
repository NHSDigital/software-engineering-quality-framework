# Dependency Scan

## Problem

The dependency scan feature can automatically find security vulnerabilities in your dependencies while you are developing and testing your applications. For example, dependency scanning lets you know if your application uses an external (open source) library that is known to be vulnerable. You can then take action to protect your application.

## Solution

### [syft](https://github.com/anchore/syft)
A CLI tool and for generating a Software Bill of Materials (SBOM) from container images and filesystems. Provides vulnerability detection when used with a scanner like Grype.

### [grype](https://github.com/anchore/grype)

A vulnerability scanner for container images and filesystems. Works with Syft, SBOM (software bill of materials) tool for container images and filesystems.

### Recipe 1a: Docker images as targets

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

```
# scan a container image archive (from the result of `docker image save ...`, `podman save ...`, or `skopeo copy` commands)
grype path/to/image.tar

# Use SBOM as input to vulnerability scan
grype sbom:./path/to/sbom.json

```

### Recipe 1b: Filesystem

```
# catalog a folder
syft path/to/dir -o cyclonedx-json=<file>
```
```
# scan a directory
grype dir:path/to/dir
```

### Recipe 2: Using Docker images, Makefile and shell scripting

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
    --volume /tmp/grype/db:/tmp/grype/db \
    --volume $(HOME)/.docker/config.json:/config/config.json \
    --volume $(PWD):/project \
    --env "DOCKER_CONFIG=/config" \
    --env "XDG_CACHE_HOME=/tmp/grype/db" \
    --workdir /project \
    anchore/grype:latest $(SCHEME) $(ARGS)
```

Run from a command-line

```bash
# Scan the repository

$ make generate-sbom SCHEME=dir:./ ARGS="-o cyclonedx-json=sbom-repo.cdx.json"
 ✔ Indexed .
 ✔ Cataloged packages      [0 packages]

$ make scan-vulnerabilities SCHEME=sbom:./sbom-repo.cdx.json
 ✔ Vulnerability DB        [updated]
 ✔ Scanned image           [0 vulnerabilities]
No vulnerabilities found
```

```bash
# Scan an image

$ make generate-sbom SCHEME=alpine:3.11.3 ARGS="-o cyclonedx-json=sbom-image.cdx.json"
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [14 packages]

$ make scan-vulnerabilities SCHEME=sbom:./sbom-image.cdx.json ARGS="--fail-on critical"
 ✔ Vulnerability DB        [updated]
 ✔ Scanned image           [71 vulnerabilities]
NAME          INSTALLED  FIXED-IN    TYPE  VULNERABILITY   SEVERITY
apk-tools     2.10.4-r3  2.10.7-r0   apk   CVE-2021-36159  Critical
apk-tools     2.10.4-r3  2.10.6-r0   apk   CVE-2021-30139  High
busybox       1.31.1-r9              apk   CVE-2022-28391  Critical
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42378  High
busybox       1.31.1-r9  1.31.1-r10  apk   CVE-2021-28831  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42374  Medium
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42380  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42385  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42381  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42384  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42386  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42382  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42379  High
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42383  High
libcrypto1.1  1.1.1d-r3  1.1.1k-r0   apk   CVE-2021-3450   High
libcrypto1.1  1.1.1d-r3  1.1.1l-r0   apk   CVE-2021-3711   Critical
libcrypto1.1  1.1.1d-r3  1.1.1j-r0   apk   CVE-2021-23841  Medium
libcrypto1.1  1.1.1d-r3  1.1.1j-r0   apk   CVE-2021-23840  High
libcrypto1.1  1.1.1d-r3  1.1.1k-r0   apk   CVE-2021-3449   Medium
libcrypto1.1  1.1.1d-r3              apk   CVE-2022-1292   Critical
libcrypto1.1  1.1.1d-r3  1.1.1j-r0   apk   CVE-2021-23839  Low
libcrypto1.1  1.1.1d-r3  1.1.1l-r0   apk   CVE-2021-3712   High
libcrypto1.1  1.1.1d-r3              apk   CVE-2022-0778   High
libcrypto1.1  1.1.1d-r3              apk   CVE-2022-2068   Critical
libcrypto1.1  1.1.1d-r3              apk   CVE-2021-4160   Medium
libcrypto1.1  1.1.1d-r3  1.1.1g-r0   apk   CVE-2020-1967   High
libcrypto1.1  1.1.1d-r3  1.1.1i-r0   apk   CVE-2020-1971   Medium
libssl1.1     1.1.1d-r3              apk   CVE-2022-0778   High
libssl1.1     1.1.1d-r3  1.1.1j-r0   apk   CVE-2021-23839  Low
libssl1.1     1.1.1d-r3              apk   CVE-2021-4160   Medium
libssl1.1     1.1.1d-r3  1.1.1l-r0   apk   CVE-2021-3712   High
libssl1.1     1.1.1d-r3  1.1.1l-r0   apk   CVE-2021-3711   Critical
libssl1.1     1.1.1d-r3  1.1.1j-r0   apk   CVE-2021-23840  High
libssl1.1     1.1.1d-r3  1.1.1k-r0   apk   CVE-2021-3449   Medium
libssl1.1     1.1.1d-r3  1.1.1j-r0   apk   CVE-2021-23841  Medium
libssl1.1     1.1.1d-r3              apk   CVE-2022-1292   Critical
libssl1.1     1.1.1d-r3  1.1.1i-r0   apk   CVE-2020-1971   Medium
libssl1.1     1.1.1d-r3  1.1.1k-r0   apk   CVE-2021-3450   High
libssl1.1     1.1.1d-r3              apk   CVE-2022-2068   Critical
libssl1.1     1.1.1d-r3  1.1.1g-r0   apk   CVE-2020-1967   High
musl          1.1.24-r0  1.1.24-r3   apk   CVE-2020-28928  Medium
musl-utils    1.1.24-r0  1.1.24-r3   apk   CVE-2020-28928  Medium
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42382  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42380  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42379  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42383  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42374  Medium
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42386  High
ssl_client    1.31.1-r9              apk   CVE-2022-28391  Critical
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42381  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42385  High
ssl_client    1.31.1-r9  1.31.1-r10  apk   CVE-2021-28831  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42378  High
ssl_client    1.31.1-r9  1.31.1-r11  apk   CVE-2021-42384  High
zlib          1.2.11-r3              apk   CVE-2018-25032  High
1 error occurred:
  * discovered vulnerabilities at or above the severity threshold
```

### Recipe 3: Using GitHub Workflow Action

An action to generate software bill of materials for the repository and a Docker image

```yaml
name: "Generate SBOM"
on:
  push:
    branches: [main]
  pull_request:
    types: [opened, synchronize, reopened]
jobs:
  generate-sbom:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: anchore/sbom-action@v0
      with:
        path: ./
        format: cyclonedx-json
        artifact-name: sbom-repo.cdx.json
    - uses: anchore/sbom-action@v0
      with:
        image: my-registry.com/my/awesome/image
        registry-username: ${{ secrets.REGISTRY_USERNAME }}
        registry-password: ${{ secrets.REGISTRY_PASSWORD }}
        format: cyclonedx-json
        artifact-name: sbom-image.cdx.json
```

An action to scan vulnerabilities based on the content of the generated sbom json file

```yaml
name: "Scan vulnerabilities"
on:
  push:
    branches: [main]
  pull_request:
    types: [opened, synchronize, reopened]
jobs:
  scan-vulnerabilities:
    runs-on: ubuntu-latest
    steps:
    - uses: anchore/scan-action@v3
      with:
        sbom: sbom-repo.cdx.json
        fail-build: true
        severity-cutoff: critical
        acs-report-enable: true
    - uses: anchore/scan-action@v3
      with:
        sbom: sbom-image.cdx.json
        fail-build: true
        severity-cutoff: critical
        acs-report-enable: true
```

## How It Works

- Syft generates SBOMs for container images, filesystems & archives to discover packages and libraries
- Supports OCI and Docker image formats
- Linux distribution identification
- Converts between SBOM formats, such as CycloneDX, SPDX, and Syft's own format.
- **[CycloneDX](https://cyclonedx.org/)** is a lightweight SBOM standard useful for application security and supply chain component analysis. CycloneDX is an open source project that originated in the OWASP community.

- **[SPDX](https://spdx.dev/)** is an ISO standard hosted by the Linux Foundation, which outlines the components, licenses, and copyrights associated with a software package.


## Further Comments

What's next
- Integrate SBOM into CI/CD piplines to provide early visibility of application dependencies.
- Consider where SBOM artifacts are stored, i.e committed and tagged in the source repository.
- Use SBOM to continually scan for new vulnerabilities as they are discovered.
