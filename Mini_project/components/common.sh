LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;31m FAILED\e[0m"
    exit 2
  fi
}

APPUSER_SETUP_WITH_APP() {
echo "Create App User"
id roboshop &>>LOG_FILE
  if [ $? -ne 0 ];then
    adduser roboshop $>>LOG_FILE
  fi
STAT $?

echo "Download ${COMPONENT} Code"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG_FILE
STAT $?

echo "Extract ${COMPONENT} Code"
    cd /tmp/
    unzip -o ${COMPONENT}.zip &>>$LOG_FILE
STAT $?

echo "Clean Old ${COMPONENT} Content"
  rm -rf /home/roboshop/${COMPONENT}
STAT $?

echo "Copy ${COMPONENT} Content"
  cp -r ${COMPONENT}-main /home/roboshop/${COMPONENT} &>>$LOG_FILE
  STAT $?
}


SYSTEMD_SETUP() {
  chown roboshop:roboshop /home/roboshop/ -R &>>$LOG_FILE
echo "Update SystemD File"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service &>>$LOG_FILE
STAT $?

echo "Setup ${COMPONENT} SystemD file"
  mv /home/roboshop/${COMPONENT}/systemd.service  /etc/systemd/system/${COMPONENT}.service &>>$LOG_FILE
STAT $?

}
