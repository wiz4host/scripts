#########################################################################
#     This script runs at Redhat/centos and Ubuntu Systems platform     #
#     It install Python3 as alternate version of python                 #
#     It install aws-cli using python3(pip3)                            #
#########################################################################

#!/bin/bash

#Define Python Version here
PythonVer=3.6.7
PythonVerMajor=PythonVerMajor=$(echo $PythonVer|cut -c -3)
echo $PythonVerMajor


#STEP1: Install dependency for baking python source code
pkgarrcentos=( gcc openssl-devel bzip2-devel libffi-devel )
pkgarrubuntu=( build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev wget libbz2-dev )
updaterepo="y"

#grep linux  OS  type
oslinux=$(cat /etc/*-release| grep -w 'NAME='|awk -F "=" '{print $2}'|sed -e 's/^"//' -e 's/"$//'|awk -F " " '{print $1}')

#convert $os  all in lowercase
os="${oslinux,,}"


#compare for ubuntu or centos
if [[ $os == "ubuntu" ]]; then
   osinstaller="apt-get"
   pkgarr=${pkgarrubuntu[@]}
fi

if [ $os == "centos" ]; then
   osinstaller="yum"
   pkgarr=${pkgarrcentos[@]}
fi

echo "===================================================================="
echo "Linux OS = $os"
echo "package to be installed = ${pkgarr[@]}"
echo "===================================================================="


echo  ++++++++++++++++++++++++++++++++++++++++++ UPDATE Packages and Repos++++++++++++++++++++++++++++++
if [[ $updaterepo == "y" ]]; then
    sudo $osinstaller update -y
fi

echo +++++++++++++++++++++++++++++++++++++++++++INSTALL Package++++++++++++++++++++++++++++

for pkg in ${pkgarr[@]}
 do
  sudo $osinstaller -y install $pkg|grep -w 'Package'
 done


#Step2: Install and configure Python3
cd /opt/
sudo curl -O https://www.python.org/ftp/python/${PythonVer}/Python-${PythonVer}.tgz
sudo tar -xzf Python-${PythonVer}.tgz
cd Python-${PythonVer}/
sudo ./configure --enable-optimizations
sudo make altinstall
python${PythonVerMajor} --version

#Step3: Install pip3
cd ~
sudo curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python${PythonVerMajor} get-pip.py --user
sudo pip${PythonVerMajor} --version

#Step4: Install awscli
sudo pip${PythonVerMajor} install awscli --upgrade --user
awscli --version

#Export PATH
sudo export PATH=~/.local/bin:$PATH
sudo source ~/.bash_profile

#Making PATH ready for future session
echo "PATH=~/.local/bin:$PATH" | tee -a ~/.bash_profile
echo "export \$PATH" | tee -a ~/.bash_profile
~

