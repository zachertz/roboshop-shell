 COMPONENT=frontend
 source common.sh

PRINT"Install Nginx"
yum install nginx -y &>>$LOG
STAT $?

PRINT"Download APP Code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/static/* .
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx
systemctl restart nginx
