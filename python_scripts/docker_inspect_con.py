import json
import subprocess
import sys
import getopt


options, remainder = getopt.getopt(sys.argv[1:], 'c:k:h', ['cmd=', 'key=','help',])

for opt, arg in options:
    if opt in ('-c', '--cmd'):
        cmd = arg
    elif opt in ('-k', '--key'):
        key = arg
    elif opt in ('-h', '--help'):
        help = arg

if opt=='-h' or opt=='--help':
    print '''Syntax:
             python dockerjson_stdout.py -c 'docker inspect <con_name>' -k <Mounts>
             python dockerjson_stdout.py -cmd 'docker inspect <con_name>' -key <Mounts>

             python dockerjson_stdout.py --help

             WHERE:
             -c, --cmd => docker command closed under quotes. E.g: docker inspect <con_name/id>
             -k, --key => Pass top level key for which you need details. When script will run it will list all the possible top level keys which you can provide to sript for getting that specific details. These keys are:

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

             -h, --help => use for getting help

               
             '''
    sys.exit()

print "KEY: ",key
print "Docker command: ",cmd




json_key = key
dcmd = cmd
doutput = subprocess.Popen(dcmd, shell=True, stdout=subprocess.PIPE)
output = doutput.communicate()

print "LIST of Main Keys:"
print "====================================="
for k in json.loads(output[0].replace('\n',''))[0]:
    print k


print "\n\n"

print "Value of passed key:"
print "====================================="
parsed = json.loads(output[0].replace('\n',''))[0][key]
print json.dumps(parsed, indent=2, sort_keys=True)



