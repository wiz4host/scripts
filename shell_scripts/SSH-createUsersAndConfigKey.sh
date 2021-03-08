#!/bin/bash
 
#set -x

#Note:
#this is only for CentOS/Redhat family OS

#This script do below things:
#1) Generate same set of users listed in user_list.txt file on multiple machines listed in machine_list.txt.
#2) for any user, it reset password, copy public key, set password exopiry and add them to wheel group (for sudo acess)
#3) Basically created for Remote execution and beneficial in situation when you have multiple machines to work on.

#Requisuite:
# yum install -y sshpass

#How to Use:
#1) spin up one Linux VM and install sshpass on that. Then keep this script in some path and genearte machine_list.txt & user_list.txt at same path.
#example: /opt/script/SSH-createUsersAndConfigkey.sh, /opt/script/user_list.txt, /opt/script/machine_list.txt
 
#Make Sure you have key generated which is required to be pushed to remote server (public key).
#ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''  #Generate Key pair. Run this seperately.
 
 
each_user_pwd='XXXXXXXXXXXXXX'
 
for each_machine in `cat machine_list.txt`
do
   for each_user in `cat user_list.txt`
    do
      echo "=============${each_user}@${each_machine}============================"
      sshpass -p ${each_user_pwd} ssh root@${each_machine} "/usr/sbin/adduser --shell /bin/bash -m  ${each_user}"
      sshpass -p ${each_user_pwd} ssh root@${each_machine} "echo -e '${each_user_pwd}\n${each_user_pwd}' | passwd ${each_user}"
      sshpass -p ${each_user_pwd} ssh-copy-id -i ~/.ssh/id_rsa_ansible.pub  ${each_user}@${each_machine}
      sshpass -p ${each_user_pwd} ssh root@${each_machine} "chage -I -1 -m 0 -M 99999 -E -1 ${each_user}"
      sshpass -p ${each_user_pwd} ssh root@${each_machine}  "usermod -aG wheel ${each_user}"
     echo "=======================================================================/n/n"
    done
done
