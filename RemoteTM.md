# [RemoteTM 5.0 Web Server](https://www.maxprograms.com/products/remotetm.html)
Running RemoteTM 5.0 on Ubuntu in a Proxmox container.

### Installed software:
* Ubuntu 20.04.03
* OpenJDK 17.0.1
* Tomcat 9.0.56
* RemoteTM Web Server 5.0.0
  
## Setup Ubuntu container
Update & Upgrade
```
apt update && apt upgrade -y
```
Allow root ssh access by adding PermitRootLogin
```
vim.tiny /etc/ssh/sshd_config

####################ADD TEXT####################
PermitRootLogin yes
################################################
```
Restart ssh server
```
service ssh restart
```
Set Local unicode
```
locale-gen en_US.UTF-8
```
Command to generate the ```/etc/default/locale```
```
update-locale LANG=en_US.UTF-8
```
Test to show locale environment variables
```
local
```
Install required software
```
apt install vim tar wget -y
```
## Install & configure Java
Install java 17
```
apt install openjdk-17-jdk -y
```
Show Java path
```
update-alternatives --config java
```
Add Java to environment file
```
vim /etc/environment

####################ADD TEXT####################
JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/bin/java
################################################
```
Edit the .bashrc config file for Java home location
```
vim ~/.bashrc

####################ADD TEXT####################
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
################################################
```
Reload .bashrc file and verify path
```
source ~/.bashrc
echo $JAVA_HOME
```
## Install & configure Tomcat 9
Make Tomcat directory
```
mkdir -p /opt/tomcat
```
Download Tomcat from the [Official Webpage](https://tomcat.apache.org/download-90.cgi)
```
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.64/bin/apache-tomcat-9.0.64.tar.gz
```
Extract Tomcat into Tomcat directory
```
tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
```
Create Tomcat group and user
```
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
```
Assign the correct permissions to the Tomcat folders
```
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*
```
Edit the .bashrc config file for Tomcat home location
```
vim ~/.bashrc

####################ADD TEXT####################
export CATALINA_HOME=/opt/tomcat
################################################
```
Reload .bashrc file and verify path
```
source ~/.bashrc
echo $CATALINA_HOME
```
Add Apache Tomcat as a Systemd Service
```
vim /etc/systemd/system/tomcat.service

####################ADD TEXT####################
[Unit]
Description=Apache Tomcat 9 Servlet Container
After=syslog.target network.target

[Service]
User=tomcat
Group=tomcat
Type=forking
Environment=CATALINA_PID=/opt/tomcat/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
################################################
```
Reload systemd
```
systemctl daemon-reload
```
Start Apache Tomcat service and add it to system boot
```
systemctl start tomcat
systemctl enable tomcat
```
Check if Apache Tomcat service is running and ports
```
ss -plnt
systemctl status tomcat
```
Configure Tomcat user configuration file. Change ***USER*** & ***PASS***
```
vim /opt/tomcat/conf/tomcat-users.xml

####################ADD TEXT####################
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="USER" password="PASS" roles="admin,admin-gui,manager,manager-gui"/>
################################################
```
Edit Tomcat context file for manager. Comment out block.
```
vim /opt/tomcat/webapps/manager/META-INF/context.xml

####################MOD TEXT####################
<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
################################################
```
Edit Tomcat context file for host-manager. Comment out block.
```
vim /opt/tomcat/webapps/host-manager/META-INF/context.xml

####################MOD TEXT####################
<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
################################################
```
Restart Tomcat
```
systemctl restart tomcat
```
Access Tomcat web interface
* http://localhost:8080
* http://ip-addres:8080
* http://youdomain.com:8080

---

## Install SSL certificate on Tomcat Server ([Comodo SSL]([https://zerossl.com/](https://comodosslstore.com/resources/tomcat-ssl-ssl-certificates-for-tomcat-servers/)
Make certs directory.
```
mkdir -p /opt/certs
```
Create a kestore in ```/opt/certs``` directory.
```
keytool -genkey -keysize 2048 -keyalg RSA -noprompt -alias server -dname "CN=domain.local, OU=IT, O=Business, L=City(full name, S=State(full name), C=USA" -keystore domain.local.jks -validity 9999 -storepass PASSWORD -keypass PASSWORD
```

Create a CSR text file.
```
keytool -certreq -alias server -file csr.txt -keystore domain.local.jks
```

Make a backup of the kestore.
```
cp domain.local.jks domain.local.jks.bak
```

Instrucations for [ssl certificates](https://comodosslstore.com/ssl-certificates)
* Copy/pasting the CSR (open the .txt file) into the relevant field (usually the one labelled CSR).
* Once the purchase and validation are complete, find SSL certificate (PKCS7 File).
* Create domain.local.p7b file.
* Copy contents of the PKCS7.p7b file inside the following domain.local.p7b file:
```
-----BEGIN PKCS7-----
data...
-----END PKCS7-----
```

Install SSL Certificate inside the keystore
```
keytool -import -alias server -file domain.local.p7b -keystore domain.local.jks
```

Configure server.xml with SSL Certificates
```
vim /opt/tomcat/conf/server.xml

####################ADD TEXT####################
<Connector 
	port="8443" 
	maxHttpHeaderSize="8192" 
	maxThreads="100"
	minSpareThreads="25" 
	maxSpareThreads="75"
	enableLookups="false" 
	disableUploadTimeout="true"
	acceptCount="100" 
	scheme="https" 
	secure="true"
	SSLEnabled="true" 
	clientAuth="false"
	sslProtocol="TLS" keyAlias="server"
	keystoreFile="/opt/certs/domain.local.jks"
	keystorePass="PASSWORD" 
/>
################################################
```

Restart Tomcat
```
systemctl restart tomcat
```
Check if Apache Tomcat service is running and ports
```
ss -plnt
systemctl status tomcat
```
---

## Install RemoteTM
Download [RemoteTM](https://www.maxprograms.com/downloads/RemoteTM/RemoteTM.war) on local computer.

Go to Tomcat Web Application Manager
* https://localhost:8443/manager/html/list
* Scroll down to ***WAR file to deploy***.
* Select ***Choose File***.
* Add [RemoteTM.war](https://www.maxprograms.com/downloads/RemoteTM/RemoteTM.war) from local computer.
* Click ***Deploy***.

or
```
wget https://www.maxprograms.com/downloads/RemoteTM/RemoteTM.war -P /opt/tomcat/webapps/
```

## Web Access
* Luanch RemoteTM by going to the following link http://localhost:8443/RemoteTM
* Login with these default credentials: User Name: ***sysadmin*** Password: ***secData***
---
## Notes
RemoteTM server files.
```
cd /opt/tomcat/.config/RemoteTM
```
---

## References
* https://www.howtoforge.com/how-to-install-java-17-jdk-17-on-debian-11/
* https://www.howtoforge.com/tutorial/ubuntu-apache-tomcat/
* https://www.how2shout.com/linux/install-apache-tomcat-10-on-debian-11-linux/
* https://comodosslstore.com/resources/tomcat-ssl-ssl-certificates-for-tomcat-servers/
* https://comodosslstore.com/positivessl.aspx
* https://certpanel.com/
