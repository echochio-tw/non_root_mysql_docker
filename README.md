# non_root_mysql_docker

```
# https://github.com/chio-nzgft/non_root_mysql_docker.git
# docker build -t non_root_mysql .

```

Run host (192.168.0.70) 
```
# docker run -d -P  --privileged=true -p 192.168.0.70:8080:8080 --name=non_root_mysql   non_root_mysql 
```
