# non_root_mysql_docker

```
# https://github.com/chio-nzgft/non_root_mysql_docker.git
# docker build -t non_root_mysql .

```

Run host (192.168.0.70) 
```
# docker run -d -P  --privileged=true -p 192.168.0.70:3306:3306 --name=non_root_mysql non_root_mysql 
```

login mysql ( password in Dockerfile)

user : root

pass : rootpass

```
# mysql -h 192.168.0.70 -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.16 MySQL Community Server (GPL)

Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]>
```
