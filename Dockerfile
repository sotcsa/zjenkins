FROM jenkins/jenkins:jdk11
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/casc.yaml

USER root
RUN apt update -y && \
    apt install -y python3-pip

RUN pip3 install awscli git-remote-codecommit --upgrade

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# copy the seedjob file into the image
#RUN mkdir -p /var/jenkins_home/jobdsl/
#COPY seedjob.groovy /var/jenkins_home/jobdsl/seedjob.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# copy the config-as-code yaml file into the image
COPY casc.yaml /var/casc.yaml

COPY openjdk-15.0.2_linux-x64_bin.tar.gz /tmp/openjdk-15.0.2_linux-x64_bin.tar.gz
RUN cd /usr/local/ && tar zvfx /tmp/openjdk-15.0.2_linux-x64_bin.tar.gz && rm -f /tmp/openjdk-15.0.2_linux-x64_bin.tar.gz
