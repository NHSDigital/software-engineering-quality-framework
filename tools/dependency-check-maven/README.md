# dependency-check-maven

## What it does

dependency-check-maven is a Maven Plugin that uses dependency-check-core to detect publicly disclosed vulnerabilities associated with the project's dependencies. The plugin will generate a report listing the dependency, any identified Common Platform Enumeration (CPE) identifiers, and the associated Common Vulnerability and Exposure (CVE) entries.

Full example is included in this folder.

## Running from maven

### Add the plugin to your POM file

```xml
<plugin>
  <groupId>org.owasp</groupId>
  <artifactId>dependency-check-maven</artifactId>
  <version>${dependency-check-maven.version}</version>
  <configuration>
    <versionCheckEnabled>true</versionCheckEnabled>
    <formats>
      <format>html</format>
      <format>json</format>
    </formats>
    <!-- these analyzers cause errors -->
    <bundleAuditAnalyzerEnabled>false</bundleAuditAnalyzerEnabled>
    <!-- these are known ones that we are ignoring for now -->
    <suppressionFiles>cve-suppressions.xml</suppressionFiles>
  </configuration>
  <executions>
    <execution>
      <phase>none</phase>
      <goals>
        <goal>check</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

More configuration options: https://jeremylong.github.io/DependencyCheck/dependency-check-maven/configuration.html

### Create an exclusion file

(cve-suppressions.xml in the example above).
This file allows you to exclude patterns of vulnerabilities, with a date:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<suppressions xmlns="https://jeremylong.github.io/DependencyCheck/dependency-suppression.1.3.xsd">

    <!-- Only fail build for Majors and above -->
    <suppress>
        <cvssBelow>6</cvssBelow>
    </suppress>

    <!-- To be fixed by SpringBoot upgrade: ticket ABC-1234 -->
    <suppress until="2021-11-01Z">
        <filePath regex="true">.*spring-core-5.3.4.jar</filePath>
        <cvssBelow>10.0</cvssBelow>
    </suppress>

    etc.
</suppressions>
```

### Run the maven goal

`mvn org.owasp:dependency-check-maven:aggregate -B -q -s settings.xml -f ./webapp/pom.xml`

(aggregate is the target for a multi-module maven project)

## Integrating into Sonarqube

The plugin definition in the POM file says which formats to output the report in. Sonarqube wants both json and html.

These will be output to the `target` folder of your parent project, and will be called `dependency-check-report.json` and `dependency-check-report.html` by default.

To get sonar-scanner to pick them up, include the `-Dsonar.dependencyCheck.jsonReportPath` and `htmlReportPath` parameters:

```bash
sonar-scanner \
      -Dsonar.sources=/usr/src \
      -Dsonar.java.binaries=/usr/binaries \
      -Dsonar.projectKey="my-app:master" \
      -Dsonar.projectVersion="2" \
      -Dsonar.host.url=$SONARQUBE_SERVER_URL \
      -Dsonar.login=$SONARQUBE_AUTH_TOKEN \
      etc... \
      -Dsonar.dependencyCheck.jsonReportPath=/usr/binaries/dependency-check-report.json \
      -Dsonar.dependencyCheck.htmlReportPath=/usr/binaries/dependency-check-report.html
```
