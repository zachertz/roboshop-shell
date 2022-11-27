 source common.sh

 PRINT"INSTALL NODEJS REPOS"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash
 STAT $?

 PRINT"INSTALL NODEJS"
 yum install nodejs -y
 STAT $?

 PRINT"ADD APPLICATION USER"
 useradd roboshop
STAT $?

PRINT"DOWNLOAD APP CONTENT"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
STAT $?

PRINT"REMOVE PREVIOUS VERSION OF APP"
cd /home/roboshop
rm -rf cart
STAT $?

PRINT"EXTRACTING APP CONTENT"
unzip -o /tmp/cart.zip
STAT $?

mv cart-main cart
cd cart

PRINT "INSTALL NODEJS DEPENDENCIES"
npm install
STAT $?

PRINT "CONFIGURE ENDPOINTS FOR SYSTEMD CONFIGERATION"
sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.devopsb69.online/' /home/roboshop/cart/systemd.service
STAT $?

PRINT "SETUP SYSTEMD SERVICES"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
STAT $?

PRINT "RELOAD SYSTEMD"
systemctl daemon-reload
STAT $?

PRINT"RESTART CART"
systemctl restart cart
STAT $?

PRINT"ENABLE CART SERVICE"
systemctl enable cart
STAT $?