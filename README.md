# scripts
scripts for various situations

Script: docker_inspect_con.py

Syntax: python docker_inspect_con.py -c 'docker inspect <Container_name>' -k '<key_name>'

LIST of Main Keys:
=====================================
Platform
State
Config
ResolvConfPath
HostsPath
Args
Driver
Path
HostnamePath
RestartCount
Name
Created
ExecIDs
GraphDriver
Mounts
ProcessLabel
NetworkSettings
AppArmorProfile
Image
LogPath
HostConfig
Id
MountLabel


Example:
 python docker_inspect_con.py -c 'docker inspect jenkins2x144_ubuntu_custom_con001' -k 'Platform'
