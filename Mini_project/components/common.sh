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

APPUSER_SETUP_WITH_APP()
{
  echo "Create App User"

  id roboshop &>>LOG_FILE
  if [ $? -ne 0 ];then
    adduser roboshop $>>LOG_FILE
  fi
  STAT $?

  echo "Download ${COMPONENT} Code"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG_FILE
    STAT $?
}
