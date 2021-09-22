FROM openjdk:8-jre

LABEL author="waisy" email="thewaisy@gmail.com"
LABEL version="0.1"

ARG PRESTO_VERSION=0.261

# Set the URL to download
ARG PRESTO_BIN=https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz

# Update the base image OS and install wget and python
RUN apt-get update && \
    apt-get install -y wget \
        python \
        less

# Download Presto and unpack it to /opt/presto
RUN wget --quiet ${PRESTO_BIN} && \
    mkdir -p /opt && \
    tar -xvzf presto-server-${PRESTO_VERSION}.tar.gz -C /opt && \
    rm presto-server-${PRESTO_VERSION}.tar.gz && \
    ln -s /opt/presto-server-${PRESTO_VERSION} /opt/presto 

# Copy configuration files on the host into the image
# COPY etc /opt/presto/etc
RUN ln -s /opt/presto/etc /etc/presto

# Download the Presto CLI and put it in the image
RUN wget --quiet https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar
RUN mv presto-cli-${PRESTO_VERSION}-executable.jar /usr/local/bin/presto
RUN chmod +x /usr/local/bin/presto

# Specify the entrypoint to start
ENTRYPOINT /opt/presto/bin/launcher run