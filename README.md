# docker_wp_sqlcluster
a docker stack with wordpress and galera cluster

Additional plugins and themes can be included in the stack using environment variables
ex:  -e ADDONS_plugins_1=https://downloads.wordpress.org/plugin/amazon-s3-and-cloudfront.1.3.2.zip

Running the Stack
It needs external netwrok
docker network create -d overlay to-the-whole-world --attachable


cmd /V /C "set MYSQL_ROOT_PASSWORD=XXXXXXXXXXXXXXXX&& set S3_BUCKET=XXXXXXXXXXXXXXXX&& set S3_ACCESSID=XXXXXXXXXXXXXXXX&& 
	set S3_ACCESSKEY=XXXXXXXXXXXXXXXX&& set DISCOVERYURL=http://172.17.0.1:2379/v2/keys&& docker-compose up"



The container backs up the data to s3 every 6 hours

to restore the database:
download the backup C:\tmp\restores and rename to backup.sql

docker run -it --rm --network backend_default -v C:\tmp\restore:/dbdata  alpine /bin/sh

cd /dbdata
apk add --no-cache mysql-client
mysql -u root -h  mysql-galera -pa3JRlcIJaJ7sPLmkzudG
show databases;
drop database wordpress;
create database wordpress;
use wordpress;
source backup.sql;



