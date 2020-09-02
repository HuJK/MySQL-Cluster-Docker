FROM centos:7
COPY install.sh /tmp/install.sh
RUN bash /tmp/install.sh
COPY move2docker /tmp/move2docker
RUN rsync -a --no-perms --no-owner --no-group --chmod=755 --keep-dirlinks /tmp/move2docker/* /;
VOLUME ["var/lib/mysql-cluster/"]
ENTRYPOINT ["ndb_mgmd"]
CMD ["--config-file=/var/lib/mysql-cluster/config.ini","--reload","--skip-daemon"]
