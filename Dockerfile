FROM ubuntu:16.04
RUN apt-get update && apt -y dist-upgrade
RUN apt-get install -y wget
RUN useradd mysql
WORKDIR /home
RUN wget https://downloads.mysql.com/archives/get/file/mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz
RUN tar zxvf mysql-5.7.16-linux-glibc2.5-x86_64.tar.gz
RUN mv mysql-5.7.16-linux-glibc2.5-x86_64 mysql
ADD my.cnf /home/mysql
RUN chown -R mysql /home/mysql
EXPOSE 3306
USER mysql
RUN echo "#!/bin/bash" > /home/mysql/start.sh
RUN echo "cd /home/mysql;./bin/mysqld_safe --defaults-file=/home/mysql/my.cnf &" >> /home/mysql/start.sh
RUN echo "while true; do" >> /home/mysql/start.sh
RUN echo "sleep 5" >> /home/mysql/start.sh
RUN echo "done" >> /home/mysql/start.sh
RUN chmod +x /home/mysql/start.sh
ENTRYPOINT /home/mysql/start.sh
