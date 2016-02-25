#!/bin/bash
#===============================================================================
#          FILE:  middleware.sh#
#         USAGE:  ./middleware.sh
#        AUTHOR:  Carol Guillen, guillen.carolina@gmail.com
#       VERSION:  1.0
#   DESCRIPTION: script de start|stop do middleware Oracle 11g

#chmod 750 /etc/init.d/middleware
#chkconfig --add middleware
#===============================================================================

RETVAL=0

WL_DOMAIN="/home/carol/oracle/middleware1036/user_projects/domains/base_domain"
SCRIPT_HOME="/home/carol/repository/sciensa-stelo/stelo-alm/weblogic_scripts/WLST"
JAVA_OPTIONS="-Dweblogic.security.SSL.ignoreHostnameVerification=true -Dweblogic.ssl.JSSEEnabled=true -Dweblogic.security.SSL.enableJSSE=true -Djava.security.egd=file:/dev/./urandom -Duser.timezone=GMT"
fileDate=`date '+%F_%H%M'`
logFileName=middleware.log.$fileDate

start() {
  source $WL_DOMAIN/bin/setDomainEnv.sh
  echo "***************** WLST startDomain"
  java $JAVA_OPTIONS weblogic.WLST -skipWLSModuleScanning $SCRIPT_HOME/startDomain.py
  return $RETVAL
}

stop() {
  source $WL_DOMAIN/bin/setDomainEnv.sh
  echo "***************** WLST stop"
  java $JAVA_OPTIONS weblogic.WLST -skipWLSModuleScanning $SCRIPT_HOME/stopDomain.py
  echo "Shutdown com sucesso" >>  $SCRIPT_HOME/$logFileName
  return $RETVAL
}

status() {
  source $WL_DOMAIN/bin/setDomainEnv.sh
  echo "***************** WLST status"
  java $JAVA_OPTIONS weblogic.WLST -skipWLSModuleScanning $SCRIPT_HOME/statusDomain.py
  return $RETVAL
}

case "$1" in
start)
echo "Go to START..."
start
;;
stop)
stop
;;
status)
echo checking runtime status
status
;;
*)

echo $"Usage: $0 {start|stop|status}"
exit 1
esac

exit $?
