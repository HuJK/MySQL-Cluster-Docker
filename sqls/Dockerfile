FROM centos:7
COPY install.sh /tmp/install.sh
RUN bash /tmp/install.sh
COPY move2docker /tmp/move2docker
RUN rsync -a --no-perms --no-owner --no-group --chmod=755 --keep-dirlinks /tmp/move2docker/* /;chmod 755 /root
VOLUME ["/var/lib/mysql","/root/mysql_backup","/root/.config/rclone"]
ENTRYPOINT ["/etc/rc.local"]
