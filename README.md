# MySQL-Cluster-Docker
MySQL Clustering with Docker

```bash
docker swarm init --advertise-addr 192.168.177.1
#Add all other computers into nodes

docker network create  --opt encrypted --driver overlay --attachable --subnet 172.34.0.0/16 fcs_cluster
docker run -it -d restart=always --init --network fcs_cluster --ip=172.34.2.101 --name=mgmd_1 mgmd
docker run -it -d restart=always --init --network fcs_cluster --ip=172.34.2.102 --name=mgmd_2 mgmd

docker run -it -d --restart=always --init --network fcs_cluster --ip=172.34.3.101 --name=sqld_1 sqld
docker run -it -d --restart=always --init --network fcs_cluster --ip=172.34.3.102 --name=sqld_2 sqld

docker run -it -d --restart=always --init --network fcs_cluster --ip=172.34.4.101 --name=ndbd_1 ndbd
docker run -it -d --restart=always --init --network fcs_cluster --ip=172.34.4.102 --name=ndbd_2 ndbd
```
