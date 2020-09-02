yum install -y epel-release
rpm -i https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y yum-utils rsync
yum-config-manager --enable mysql-cluster-8.0-community
yum install -y mysql-cluster-community-management-server
yum install -y mysql-cluster-community-client
#yum install -y epel-release
#rpm -i https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm
#yum install -y yum-utils rsync perl perl-DBI perl-Class-MethodMaker python2
#yum-config-manager --enable mysql-cluster-8.0-community
#yum install -y mysql-cluster-community-management-server
#rpm -Uvh https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-ndbclient-8.0.21-1.el8.x86_64.rpm
#rpm -Uvh https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-common-8.0.21-1.el8.x86_64.rpm
#rpm -Uvh https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-libs-8.0.21-1.el8.x86_64.rpm
#rpm -Uvh https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-client-8.0.21-1.el8.x86_64.rpm
