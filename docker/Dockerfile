FROM jenkins/jenkins:jdk11
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/casc.yaml

#USER root
#RUN apt update -y && \
#    apt install -y python3-pip

COPY docker/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# copy the config-as-code yaml file into the image
COPY docker/casc.yaml /var/casc.yaml

#COPY openjdk-15.0.2_linux-x64_bin.tar.gz /tmp/openjdk-15.0.2_linux-x64_bin.tar.gz
#RUN cd /usr/local/ && tar zvfx /tmp/openjdk-15.0.2_linux-x64_bin.tar.gz && rm -f /tmp/openjdk-15.0.2_linux-x64_bin.tar.gz
