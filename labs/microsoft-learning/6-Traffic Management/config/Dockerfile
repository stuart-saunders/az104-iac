FROM centos:7

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN yum check-update; \
    yum install -y gcc libffi-devel python3 epel-release; \
    yum install -y python3-pip; \
    yum install -y wget; \
    yum clean all

RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install pywinrm[kerberos]; \
    pip3 install pywinrm; \
    pip3 install jmspath; \
    pip3 install requests; \
    python3 -m pip install ansible; \
    ansible-galaxy collection install azure.azcollection; \
    pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

# Install Azure CLI
# RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc &&\
#     echo -e "[azure-cli]\n\
# name=Azure CLI\n\
# baseurl=https://packages.microsoft.com/yumrepos/azure-cli\n\
# enabled=1\n\
# gpgcheck=1\n\
# gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee \
# /etc/yum.repos.d/azure-cli.repo &&\
#     yum install azure-cli -y