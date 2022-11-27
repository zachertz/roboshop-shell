curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
dnf module disable mysql -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
yum install mysql-community-server -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
systemctl enable mysqld
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi
systemctl restart mysqld
if [ $? -eq 0 ]; then
  echo SUCCESS
else
    echo FAILURE
  fi