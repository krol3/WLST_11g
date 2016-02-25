__author__ = "Carol Guillen"
__version__ = "1.0.0"
__email__ = "guillen.carolina@gmail.com"
__status__ = "Prototype"

import time, ConfigParser
sleep=time.sleep

SCRIPT_HOME="/home/carol/repository/sciensa-stelo/stelo-alm/weblogic_scripts/WLST"
config = ConfigParser.ConfigParser()
file=SCRIPT_HOME+'/local.cfg'
config.read(file)

wlHome = config.get('default', 'wl.home')
user = config.get('default', 'user')
password = config.get('default', 'pass')
host = config.get('default', 'host')
domainName = config.get('default','domain.name')
nmPort = config.get('default','nm.port')
domainDir = config.get('default','domain.dir')
nmPort = config.get('default','nm.port')
nmType = config.get('default','nm.type')
domainAdmin = config.get('default','domain.admin')
domainSoa = config.get('default','domain.soa')
domainOsb = config.get('default','domain.osb')

try:
    sleep(10)
    nmConnect(user, password, host,nmPort,domainName,domainDir,nmType)
except:
    sleep(15)
print "********* nmConnect : " + host

shutdown(domainSoa,force='true')
sleep(10)
print "************  shutdown: **** "+ domainSoa

shutdown(domainOsb,force='true')
sleep(10)
print "************  shutdown: **** "+ domainOsb

shutdown(domainAdmin,force='true')
sleep(10)

try:
    nmKill(domainAdmin)
    print "************  shutdown: **** "+ domainAdmin
except:
    print "Stopping node manager"
    stopNodeManager()

print "Stopping node manager"
stopNodeManager()
print "*************** Domain is down"

nmDisconnect()
exit()
