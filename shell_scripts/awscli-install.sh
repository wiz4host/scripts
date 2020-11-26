######################################################
#     This script runs at Redhat/centos platform     #
#     It install aws-cli using python3.8 and pip3.8  #
######################################################

#!/bin/bash
# Install AWS-CLI with Python3
yum install gcc openssl-devel bzip2-devel libffi-devel -y
cd /opt/
curl -O https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tgz
tar -xzf Python-3.8.1.tgz
cd Python-3.8.1/
./configure --enable-optimizations
make altinstall
python3.8 --version

#Install pip3
cd ~
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python3.8 get-pip.py --user
pip3.8 --version

#Install awscli
pip3.8 install awscli --upgrade --user
awscli --version

#Export PATH
export PATH=~/.local/bin:$PATH
source ~/.bash_profile

#Making PATH ready for future session
echo "PATH=~/.local/bin:$PATH" | tee -a ~/.bash_profile
echo "export \$PATH" | tee -a ~/.bash_profile
