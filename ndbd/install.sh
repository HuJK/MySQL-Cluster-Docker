yum install -y epel-release
rpm -i https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y yum-utils rsync
yum-config-manager --enable mysql-cluster-8.0-community
yum install -y mysql-cluster-community-data-node
