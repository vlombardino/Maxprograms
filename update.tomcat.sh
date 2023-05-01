#!/bin/sh
##

##########################################################################
#####################    Change Information below    #####################

### Get file from [https://tomcat.apache.org/download-90.cgi] --> Core: tar.gz ###
TCDL="https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.74/bin/apache-tomcat-9.0.74.tar.gz"

### Change if tomcat file name changes ###
TCVS="apache-tomcat-*tar.gz"

##########################################################################
#####################          Start Script          #####################

### Current version ###
echo "Current version:"
cat /opt/tomcat/RELEASE-NOTES | grep "Apache Tomcat Version"
echo

### Stop tomcat services ###
echo "Shutting down tomcat services ..."
systemctl stop tomcat
echo
sleep 1

### Backup config Files ###
echo "Backing up config files ..."
cp /opt/tomcat/conf/tomcat-users.xml /tmp/tomcat-users.xml
cp /opt/tomcat/webapps/manager/META-INF/context.xml /tmp/m.context.xml
cp /opt/tomcat/webapps/host-manager/META-INF/context.xml /tmp/hm.context.xml
cp /opt/tomcat/conf/server.xml /tmp/tomcat-server.xml
echo

### Download Tomcap specified above ###
echo "Downloading file ..."
wget -q ${TCDL} -P /tmp/
tar xzf /tmp/${TCVS} -C /opt/tomcat --strip-components=1
echo

### Restore config files ###
echo "Restoring config files ..."
mv /tmp/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
mv /tmp/m.context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
mv /tmp/hm.context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml
mv /tmp/tomcat-server.xml /opt/tomcat/conf/server.xml
echo
sleep 1

### Give correct permissions to tomcat files and folders ###
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*

### Start tomcat services ###
echo "Starting tomcat ..."
systemctl start tomcat
echo
sleep 1

### Updated version
echo "Updated Version:"
cat /opt/tomcat/RELEASE-NOTES | grep "Apache Tomcat Version"