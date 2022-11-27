 COMPONENT=Cart
 source common.sh

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
STAT $?

PRINT "DOWNLOAD APP CONTENT"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG
STAT $?

PRINT "REMOVE PREVIOUS VERSION OF APP"
cd /home/roboshop &>>$LOG
rm -rf cart &>>$LOG
STAT $?

PRINT "EXTRACTING APP CONTENT"
unzip -o /tmp/cart.zip &>>$LOG
STAT $?

mv cart-main cart
cd cart

PRINT "INSTALL NODEJS DEPENDENCIES"
npm install &>>$LOG
STAT $?

PRINT "CONFIGURE ENDPOINTS FOR SYSTEMD CONFIGERATION"
sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.devopsb69.online/' /home/roboshop/cart/systemd.service &>>$LOG
STAT $?

PRINT "SETUP SYSTEMD SERVICES"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>$LOG
STAT $?

PRINT "RELOAD SYSTEMD"
systemctl daemon-reload &>>$LOG
STAT $?

PRINT"RESTART CART"
systemctl restart cart &>>$LOG
STAT $?

PRINT"ENABLE CART SERVICE"
systemctl enable cart &>>$LOG
STAT $?