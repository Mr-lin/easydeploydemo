#!/bin/bash
APP_NAME=$1
APP_RUNNING_NAME="test-app.jar"
#check java program is exit 
is_exist(){
pid=`ps -ef|grep ${APP_RUNNING_NAME}|grep -v grep|awk '{print $2}'`
if [[ -z "${pid}" ]]; then
   return 0
else
   return 1
fi
}
#kill program
is_exist
if [[ $? -eq "1" ]]; then
 echo "${APP_RUNNING_NAME} is running. Pid is ${pid}"
 echo "kill ${APP_RUNNING_NAME}"
 kill -9 ${pid}
fi
if [[ -f "$APP_RUNNING_NAME" ]];then
 archive_file=`date +%Y%m%d%H%M%S.jar`
 mkdir -p ./backup
 mv -v ${APP_RUNNING_NAME} ./backup/${archive_file}
fi
mv ${APP_NAME} ./${APP_RUNNING_NAME}
nohup java -jar ./${APP_RUNNING_NAME} > /dev/null 2>&1 &
  
