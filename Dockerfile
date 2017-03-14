FROM ubuntu:16.04
RUN apt-get update && apt -y dist-upgrade
RUN apt-get install -y wget libaio1
RUN useradd mysql
WORKDIR /home
RUN wget https://downloads.mysql.com/archives/get/file/mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz
RUN tar zxvf mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz
RUN mv mysql-5.7.16-linux-glibc2.5-x86_64 mysql
RUN mkdir /home/mysql/sql_data
RUN chown -R mysql /home/mysql
RUN rm -rf mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz
EXPOSE 3306
USER mysql
RUN echo "[server]" > /home/mysql/my.cnf
RUN echo "user=mysql" >> /home/mysql/my.cnf
RUN echo "basedir=/home/mysql/mysql" >> /home/mysql/my.cnf
RUN echo "datadir=/home/mysql/sql_data" >> /home/mysql/my.cnf
RUN echo "port=3306" >> /home/mysql/my.cnf
RUN echo "update mysql.user set authentication_string=password('rootpass') , password_expired='N' where user='root';" > /home/mysql/pass.sql
RUN echo "update mysql.user set  host='%' where user='root';" >> /home/mysql/pass.sql
RUN echo "flush privileges;" >> /home/mysql/pass.sql
RUN echo "#!/bin/bash" > /home/mysql/start.sh
RUN echo "if [ ! -d "/home/mysql/sql_dat/mysql" ]; then" >> /home/mysql/start.sh
RUN echo "cd /home/mysql;./bin/mysqld --user=mysql --basedir=/home/mysql --datadir=/home/mysql/sql_data --initialize-insecure" >> /home/mysql/start.sh
RUN echo "cd /home/mysql;./bin/mysqld_safe --defaults-file=/home/mysql/my.cnf  --init-file=/home/mysql/pass.sql &" >> /home/mysql/start.sh
RUN echo "else" >> /home/mysql/start.sh
RUN echo "cd /home/mysql;./bin/mysqld_safe --defaults-file=/home/mysql/my.cnf &" >> /home/mysql/start.sh
RUN echo "fi" >> /home/mysql/start.sh
RUN echo "while true; do" >> /home/mysql/start.sh
RUN echo "sleep 5" >> /home/mysql/start.sh
RUN echo "done" >> /home/mysql/start.sh
RUN chmod +x /home/mysql/start.sh
ENTRYPOINT /home/mysql/start.sh
