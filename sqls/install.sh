yum install -y epel-release
yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y https://repo.percona.com/yum/percona-release-latest.noarch.rpm
yum install -y yum-utils
yum-config-manager --enable mysql-cluster-8.0-community
percona-release enable-only tools
yum install -y percona-xtrabackup-80 initscripts cronie p7zip rsync mysql-server unzip busybox
curl https://rclone.org/install.sh | bash
mysqld --initialize-insecure  --user=mysql
