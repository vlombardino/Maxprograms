#!/bin/sh
##

##########################################################################
#####################          Start Script          #####################

### Current version ###
echo "Current version:"
grep -o -P '(?<=<span id="version">).*(?=</span>)' /opt/tomcat/webapps/RemoteTM/index.html
echo

### Stop tomcat services ###
echo "Shutting down tomcat services ..."
systemctl stop tomcat
echo
sleep 1

### Download Tomcap specified above ###
echo "Downloading file ..."
wget -q https://www.maxprograms.com/downloads/RemoteTM/RemoteTM.war -P /opt/tomcat/webapps/
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
grep -o -P '(?<=<span id="version">).*(?=</span>)' /opt/tomcat/webapps/RemoteTM/index.html
echo