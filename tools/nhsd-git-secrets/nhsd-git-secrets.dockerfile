###################################################################################
#
# Uses git secrets scanner to scan raw source code for secrets
# Same framework in the nhsd-git-secrets folder, but wrapped up in a docker image
#
# How to use:
# 1. Create yourself a ".gitallowed" file in the root of your project.
# 2. Add an allowed patterns to there
# 3. Add an additional providers that you want to use - uses AWS by default
# 4. "docker build" this docker file as part of your pipeline
#
# What is does:
# 1. Copies your source code into a docker image
# 2. Downloads latest version of the secret scanner tool
# 3. Downloads latest regex patterns from software-engineering-quality-framework
# 4. Runs a scan
#
##################################################################################

FROM ubuntu:latest

RUN echo "Installing required modules"
RUN apt-get update
RUN apt-get -y install curl git build-essential

# By default, we copy the entire project into the dockerfile for secret scanning
# Tweak that COPY if you only want some of the source
RUN echo "Copying source files"
WORKDIR /secrets-scanner
COPY . source
RUN ls -l source

RUN echo "Downloading secrets scanner"
RUN curl https://codeload.github.com/awslabs/git-secrets/tar.gz/master | tar -xz --strip=1 git-secrets-master

RUN echo "Installing secrets scanner"
RUN make install

# even though running secrets scanner on a folder, must still be in some kind of git repo
# for the git-secrets config to attach to something
# so init an empty git repo here
RUN echo "Configuring git"
WORKDIR /secrets-scanner/source
RUN git init

RUN echo "Downloading regex files from engineering-framework"
RUN curl https://codeload.github.com/NHSDigital/software-engineering-quality-framework/tar.gz/main | tar -xz --strip=3 software-engineering-quality-framework-main/tools/nhsd-git-secrets/nhsd-rules-deny.txt

RUN echo "Copying allowed secrets list"
COPY .gitallowed .
RUN echo .gitallowed

# Register additional providers: adds AWS by default
RUN echo "Configuring secrets scanner"
RUN /secrets-scanner/git-secrets --register-aws
RUN /secrets-scanner/git-secrets --add-provider -- cat nhsd-rules-deny.txt

# build will fail here, if secrets are found
RUN echo "Running scan..."
RUN /secrets-scanner/git-secrets --scan -r .
