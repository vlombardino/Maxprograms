# Stingray
The following are steps to install Stingray from source on Ubuntu 20.04

---

## Install software and build from source
Install required software.
```
sudo apt install openjdk-17-jdk git
sudo snap install ant --classic
sudo snap install node --classic
```
Make folder and set permissions to install Stingray.
```
sudo mkdir -p /opt/Maxprograms/
sudo chmod 777 /opt/Maxprograms
```
Switch working directory and download Stingray from github.
```
cd /opt/Maxprograms/
git clone https://github.com/rmraya/Stingray.git
cd /opt/Maxprograms/Stingray
```
Build Stingray.
```
ant
sudo npm install -g electron --unsafe-perm=true --allow-root
npm install
npm run build
```
Run *npm start* to test if Stingray will launch.
```
npm start
```
## Create desktop shortcut
Install electron into Stingray folder and launch Stingray.
```
cd /opt/Maxprograms/Stingray
sudo npm install -g electron --unsafe-perm=true --allow-root
electron .
```
Create shortcut for Gnome.
```
cat << EOF >>  ~/.local/share/applications/stingray.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Stingray
Type=Application
Exec=electron /opt/Maxprograms/Stingray
Icon=/opt/Maxprograms/Stingray/icons/icon.png
Terminal=false
GenericName=Stingray
Comment=Stingray
Categories=Stingray
EOF
```

## Update Stingray
```
git -C /opt/Maxprograms/Stingray/ pull
```
Or
```
cd /opt/Maxprograms/Stingray && git pull
```
Or remove previous version and re-download current version. Make sure to rebuild current version.
```
sudo rm -r /opt/Maxprograms/Stingray && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/Stingray.git
```
