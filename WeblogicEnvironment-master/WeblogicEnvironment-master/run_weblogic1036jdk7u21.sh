#!/bin/bash
docker rm `docker ps -a | grep weblogic | awk '{print $1}'` -f
docker rmi -f  `docker images | grep 'weblogic' | awk '{print $3}'` 
docker build --build-arg JDK_PKG=jdk-7u21-linux-x64.tar.gz --build-arg WEBLOGIC_JAR=wls1036_generic.jar  -t weblogic1036jdk7u21 .
docker run -d -p 7001:7001 -p 8453:8453 -p 5556:5556 --name weblogic1036jdk7u21 weblogic1036jdk7u21
rm -rf ./middleware
mkdir ./middleware
docker cp weblogic1036jdk7u21:/u01/app/oracle/middleware/modules ./middleware/
docker cp weblogic1036jdk7u21:/u01/app/oracle/middleware/wlserver ./middleware/