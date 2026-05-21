FROM jenkins/inbound-agent:3355.v388858a_47b_33-20

USER root

RUN apt-get update && \
    apt-get install -y \
        git \
        subversion \
        curl \
        unzip \
        python3 \
        python3-pip \
        phthon3-venv

USER jenkins
