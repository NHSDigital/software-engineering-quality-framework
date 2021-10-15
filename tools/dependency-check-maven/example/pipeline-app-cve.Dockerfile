FROM maven:3.6.0-jdk-11

# Configuration of the cve scanner is done in the parent pom.xml
# Guidance here: https://jeremylong.github.io/DependencyCheck/dependency-check-maven/configuration.html

# Run the dependency-check plugin from OWASP. Aggregate all child poms.
RUN mvn org.owasp:dependency-check-maven:aggregate -B -q -s settings.xml -f ./webapp/pom.xml

# this will dump the report file under this folder, ready to be picked up by sonar-scanner
RUN ls -l webapp/target
