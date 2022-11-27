
STAT() {
  if [ $1 -eq 0 ]; then
          echo SUCCESS
        else
            echo FAILURE
          fi
          }
echo -e "\e[32mDowloading MySQL repos file\e[om"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
STAT $?
  echo Disable MySQL 8 version repo
dnf module disable mysql -y
STAT $?
  echo install MySQL
yum install mysql-community-server -y
STAT $?
  echo enable MySQL service
systemctl enable mysqld
STAT $?
  echo  Start MySQL service
systemctl restart mysqld
STAT $?