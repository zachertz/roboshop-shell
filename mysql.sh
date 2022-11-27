
STAT() {
  if [ $1 -eq 0 ]; then
          echo SUCCESS
        else
            echo FAILURE
          fi
          }
PRINT() {
  echo -e "\e[33m$1\e[0m"
}

PRINT"Dowloading MySQL repos file"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
STAT $?
PRINT "Disable MySQL 8 version repo"
dnf module disable mysql -y
STAT $?
PRINT "install MySQL"
yum install mysql-community-server -y
STAT $?
PRINT "enable MySQL service"
systemctl enable mysqld
STAT $?
PRINT "Start MySQL service"
systemctl restart mysqld
STAT $?