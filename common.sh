STAT() {
  if [ $1 -eq 0 ]; then
          echo -e "\e[32mSUCCESS\e[0m"
        else
            echo -e "\e[31mFAILURE\e[0m"
          fi
          }
PRINT() {
  echo -e "\e[33m$1\e[0m"
}

LOG=/tmp/$COMPONENT.log
rm -f $LOG

NODEJS() {
  PRINT "INSTALL NODEJS REPOS"
   curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG
   STAT $?

   PRINT "INSTALL NODEJS"
   yum install nodejs -y &>>$LOG
   STAT $?

   PRINT "ADD APPLICATION USER"
   id roboshop &>>$LOG
   if [ $? -ne 0 ]; then
   useradd roboshop &>>$LOG
   fi
  STAT $?

  PRINT "DOWNLOAD APP CONTENT"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG
  STAT $?

  PRINT "REMOVE PREVIOUS VERSION OF APP"
  cd /home/roboshop &>>$LOG
  rm -rf ${COMPONENT} &>>$LOG
  STAT $?

  PRINT "EXTRACTING APP CONTENT"
  unzip -o /tmp/${COMPONENT}.zip &>>$LOG
  STAT $?

  mv cart-main ${COMPONENT}
  cd ${COMPONENT}

  PRINT "INSTALL NODEJS DEPENDENCIES"
  npm install &>>$LOG
  STAT $?

  PRINT "CONFIGURE ENDPOINTS FOR SYSTEMD CONFIGERATION"
  sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.devopsb69.online/' /home/roboshop/${COMPONENT}/systemd.service &>>$LOG
  STAT $?

  PRINT "SETUP SYSTEMD SERVICES"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$LOG
  STAT $?

  PRINT "RELOAD SYSTEMD"
  systemctl daemon-reload &>>$LOG
  STAT $?

  PRINT"RESTART ${COMPONENT}"
  systemctl restart ${COMPONENT} &>>$LOG
  STAT $?

  PRINT"ENABLE ${COMPONENT} SERVICE"
  systemctl enable ${COMPONENT} &>>$LOG
  STAT $?
}