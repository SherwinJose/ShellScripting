#Catalogue Service
#This service is responsible for showing the list of items that are to be sold by the RobotShop e-commerce portal.
#
#This service is written in NodeJS, Hence need to install NodeJS in the system.


source components/common.sh

echo "Set up Nodejs repo"
curl -fsSL https://npm.nodesource.com/setup_ltx.s | bash - &>>$LOG_FILE

echo "Install Node JS with dependencies"
yum install nodejs make gcc-c++ -y &>>$LOG_FILE

echo"Create Roboshop userid"
useradd roboshop &>>$LOG_FILE

echo  "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE

echo "extract catalogue code"
cd /tmp/
unzip -o /tmp/catalogue.zip &>>$LOG_FILE

echo "copy catalogue contents"
cp -r catalogue-main /home/roboshop/catalogue

echo "intall NodeJs dependencies"
cd /home/roboshop/catalogue
npm install &>>$LOG_FILE

chown roboshop:roboshop /home/roboshop -R