FROM amazonlinux

WORKDIR /tmp

RUN echo 'Install prereqs'
#RUN yum clean all && yum update -y
RUN yum -y install groff less which unzip

RUN echo 'Install AWS CLI' && \
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install

RUN echo 'Download and extract Python 3.8' && \
yum -y install gcc openssl-devel bzip2-devel libffi-devel wget tar gzip make git nano
WORKDIR /opt
RUN wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz && \
tar xzf Python-3.8.6.tgz

RUN echo 'Install Python 3.8' && \
cd Python-3.8.6 && \
./configure --enable-optimizations && \
make altinstall && \
rm -f /opt/Python-3.8.6.tgz

RUN echo 'Alias for puthon3.8' && \
echo "alias python=python3.8" >> ~/.bashrc && \
echo "alias pip=pip3" >> ~/.bashrc && \
source ~/.bashrc
