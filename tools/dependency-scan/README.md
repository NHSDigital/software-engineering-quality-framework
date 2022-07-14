# Dependency Scan

- [Dependency Scan](#dependency-scan)
  - [Problem](#problem)
  - [Design](#design)
  - [Tools](#tools)
    - [syft](#syft)
    - [grype](#grype)
  - [Solution](#solution)
    - [Recipe 1a: Docker images as targets](#recipe-1a-docker-images-as-targets)
    - [Recipe 1b: Filesystem](#recipe-1b-filesystem)
    - [Recipe 2: Using Docker images, Makefile and shell scripting](#recipe-2-using-docker-images-makefile-and-shell-scripting)
    - [Recipe 3: Using GitHub Workflow Action](#recipe-3-using-github-workflow-action)
  - [How It Works](#how-it-works)
  - [Further Comments](#further-comments)

## Problem

The dependency scan feature can automatically find security vulnerabilities in your dependencies while you are developing and testing your applications. For example, dependency scanning lets you know if your application uses an external (open source) library that is known to be vulnerable. You can then take action to protect your application.

## Design

![Dependency Scan v1](Design%20-%20Dependency%20Scan%20v1.drawio.png)

## Tools

### [syft](https://github.com/anchore/syft)

A CLI tool and for generating a Software Bill of Materials (SBOM) from container images and filesystems. Provides vulnerability detection when used with a scanner like Grype.

### [grype](https://github.com/anchore/grype)

A vulnerability scanner for container images and filesystems. Works with Syft, SBOM (software bill of materials) tool for container images and filesystems.

## Solution

### Recipe 1a: Docker images as targets

```bash
# Catalog a container image archive (from the result of `docker image save ...`, `podman save ...`, or `skopeo copy` commands)
$ docker save alpine:3.11.3 -o alpine.tar

# Specify an output format and file name
$ syft alpine.tar -o cyclonedx-json=alpine.cdx.json
 ✔ Parsed image            
 ✔ Cataloged packages      [14 packages]

```

```bash
# Convert cyclonedx-json to human readable format using json parser
$ cat alpine.cdx.json  | jq -r '(["name", "type", "version"] | (.,map(length*"-"))), (.components[] | [.name, .type, .version]) | @tsv ' | column -t
name                    type              version
----                    ----              -------
alpine-baselayout       library           3.2.0-r3
alpine-keys             library           2.1-r2
apk-tools               library           2.10.4-r3
busybox                 library           1.31.1-r9
ca-certificates-cacert  library           20191127-r0
libc-utils              library           0.7.2-r0
libcrypto1.1            library           1.1.1d-r3
libssl1.1               library           1.1.1d-r3
libtls-standalone       library           2.9.1-r0
musl                    library           1.1.24-r0
musl-utils              library           1.1.24-r0
scanelf                 library           1.2.4-r0
ssl_client              library           1.31.1-r9
zlib                    library           1.2.11-r3
alpine                  operating-system  3.11.3
```

```bash
# Use SBOM as input to vulnerability scan
$ grype sbom:./alpine.cdx.json --fail-on CRITICAL
 ✔ Vulnerability DB        [no update available]
 ✔ Scanned image           [71 vulnerabilities]
NAME          INSTALLED  FIXED-IN    TYPE  VULNERABILITY   SEVERITY 
apk-tools     2.10.4-r3  2.10.6-r0   apk   CVE-2021-30139  High      
apk-tools     2.10.4-r3  2.10.7-r0   apk   CVE-2021-36159  Critical  
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42386  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42383  High      
busybox       1.31.1-r9  1.31.1-r10  apk   CVE-2021-28831  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42378  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42380  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42382  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42385  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42381  High      
busybox       1.31.1-r9  1.31.1-r11  apk   CVE-2021-42374  Medium    
...
1 error occurred:
        * discovered vulnerabilities at or above the severity threshold

```

### Recipe 1b: Filesystem

```bash
# Catalog a folder
$ syft ./python -o cyclonedx-json=python.cdx.json
 ✔ Indexed python          
 ✔ Cataloged packages      [22 packages]

```

```bash
# Convert SBOM to human readable format using json parser
$ cat python.cdx.json  | jq -r '(["name", "type", "version"] | (.,map(length*"-"))), (.components[] | [.name, .type, .version]) | @tsv ' | column -t
name                type     version
----                ----     -------
Flask               library  2.1.2
Jinja2              library  3.1.2
MarkupSafe          library  2.1.1
Werkzeug            library  2.1.2
azure-core          library  1.24.1
azure-storage-blob  library  12.13.0
certifi             library  2022.6.15
cffi                library  1.15.0
charset-normalizer  library  2.1.0
click               library  8.1.3
cryptography        library  37.0.2
idna                library  3.3
isodate             library  0.6.1
itsdangerous        library  2.1.2
lxml                library  4.6.0
msrest              library  0.7.1
oauthlib            library  3.2.0
pycparser           library  2.21
requests            library  2.28.0
requests-oauthlib   library  1.3.1
six                 library  1.16.0
urllib3             library  1.26.9

```

```bash
# Scan a SBOM generated from file systems
$ grype sbom:./python.cdx.json --fail-on CRITICAL
 ✔ Vulnerability DB        [no update available]
 ✔ Scanned image           [7 vulnerabilities]
NAME  INSTALLED  FIXED-IN  TYPE    VULNERABILITY        SEVERITY 
lxml  4.6.0      4.6.2     python  GHSA-pgww-xf46-h92r  Medium    
lxml  4.6.0      4.9.1     python  GHSA-wrxv-2j5q-m38w  Medium    
lxml  4.6.0                python  CVE-2020-27783       Medium    
lxml  4.6.0                python  CVE-2021-28957       Medium    
lxml  4.6.0                python  CVE-2021-43818       High      
lxml  4.6.0      4.6.5     python  GHSA-55x5-fj6c-h6m8  High      
lxml  4.6.0      4.6.3     python  GHSA-jq4v-f5q6-mjqq  Medium      
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

$ make generate-sbom SCHEME="dir:./" ARGS="-o cyclonedx-json=sbom-repo.cdx.json"
 ✔ Indexed .
 ✔ Cataloged packages      [0 packages]

$ make scan-vulnerabilities SCHEME="sbom:./sbom-repo.cdx.json"
 ✔ Vulnerability DB        [updated]
 ✔ Scanned image           [0 vulnerabilities]
No vulnerabilities found
```

```bash
# Scan an image

$ make generate-sbom SCHEME="alpine:3.11.3" ARGS="-o cyclonedx-json=sbom-image.cdx.json"
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [14 packages]

$ make scan-vulnerabilities SCHEME="sbom:./sbom-image.cdx.json" ARGS="--fail-on critical"
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
