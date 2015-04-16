#! /bin/sh

set -e

MAX_MEMORY_MB=${MAX_MEMORY_MB:-1024}

cd /usr/local/crashplan
nice -n 19 /usr/local/crashplan/jre/bin/java -Dfile.encoding=UTF-8 -Dapp=CrashPlanService -DappBaseName=CrashPlan -Xms20m -Xmx${MAX_MEMORY_MB}m -Djava.net.preferIPv4Stack=true -Dsun.net.inetaddr.ttl=300 -Dnetworkaddress.cache.ttl=300 -Dsun.net.inetaddr.negative.ttl=0 -Dnetworkaddress.cache.negative.ttl=0 -Dc42.native.md5.enabled=false -classpath /usr/share/java/jna.jar:/usr/local/crashplan/lib/com.backup42.desktop.jar:/usr/local/crashplan/lang com.backup42.service.CPService
