echo -e "\e[33mDowloading MySQL repos file\e[om"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
  echo Disable MySQL 8 version repo
dnf module disable mysql -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
  echo install MySQL
yum install mysql-community-server -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
  echo enable MySQL service
systemctl enable mysqld
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
  echo  Start MySQL service
systemctl restart mysqld
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi