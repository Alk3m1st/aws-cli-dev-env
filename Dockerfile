FROM amazonlinux:2

WORKDIR /tmp

RUN echo 'Install prereqs' && \
    yum -y install groff less which unzip && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN echo 'Install some pre reqs for Python' && \
    yum -y install gcc openssl-devel bzip2-devel libffi-devel tar gzip make git nano && \
    yum clean all && \
    rm -rf /var/cache/yum

WORKDIR /opt
RUN echo 'Download and extract Python 3.8' && \
    curl "https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz" -o "Python-3.8.6.tgz" && \
    tar xzf Python-3.8.6.tgz

RUN echo 'Install Python 3.8' && \
    cd Python-3.8.6 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm -f /opt/Python-3.8.6.tgz

RUN echo 'Alias for python3.8' && \
    echo "alias python=python3.8" >> ~/.bashrc && \
    source ~/.bashrc

# Install latest LTS versions of node 8, 10 and 12 using NVM
RUN echo 'Install node via nvm' && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm install lts/carbon && \
    nvm install lts/dubnium && \
    nvm install lts/erbium && \
    nvm use lts/erbium && \
    nvm alias default node && nvm cache clear"  # Default to the latest node and empty cache

# Install AWS CLI
RUN echo 'Install AWS CLI' && \
    /bin/bash -c "python3.8 -m pip install awscli && rm -rf /var/cache/apk/*"

# Install SAM CLI
RUN echo 'Install SAM CLI' && \
    /bin/bash -c "python3.8 -m pip install aws-sam-cli"

# Install CDK CLI
RUN echo 'Install CDK CLI' && \
    source ~/.bashrc && \
    /bin/bash -c "npm install -g aws-cdk"

# Install AWS Azure Login
RUN echo 'Install AWS Azure Login' && \
    yum install -y alsa-lib atk cups-libs gtk3 libXcomposite libXcursor libXdamage libXext libXi libXrandr libXtst pango ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc && \
    yum update nss -y && \
    source ~/.bashrc && \
    /bin/bash -c "npm install -g aws-azure-login --unsafe-perm=true --allow-root" && \
    yum clean all && \
    rm -rf /var/cache/yum

# cfn-lint

ENTRYPOINT [ "bash", "-c" ]
