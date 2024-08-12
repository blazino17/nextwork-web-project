#!/bin/bash
sudo yum install tomcat -y
sudo yum -y install httpd
sudo yum -y install unzip aws-cli

# Download and unzip WAR file from S3
aws s3 cp s3://nextwork-build-artifacts-blaise/nextwork-web-build.zip /tmp/nextwork-web-build.zip
sudo unzip /tmp/nextwork-web-build.zip -d /target

sudo cat << EOF > /etc/httpd/conf.d/tomcat_manager.conf
<VirtualHost *:80>
    ServerAdmin root@localhost
    ServerName app.nextwork.com
    DefaultType text/html
    ProxyRequests off
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/nextwork-web-project/
    ProxyPassReverse / http://localhost:8080/nextwork-web-project/
</VirtualHost>
EOF
