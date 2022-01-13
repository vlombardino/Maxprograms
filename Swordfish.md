# Swordfish

## Install from source

Install required software.
```
sudo apt install openjdk-17-jdk git ant npm
```
Make folder and set permissions to install Swordfish.
```
sudo mkdir -p /opt/Maxprograms/
sudo chmod 777 /opt/Maxprograms
```
Switch working directory and download Swordfish from github.
```
cd /opt/Maxprograms/
git clone https://github.com/rmraya/Swordfish.git
cd /opt/Maxprograms/Swordfish
```
Build Swordfish
```
ant
sudo npm install -g electron --unsafe-perm=true --allow-root
npm install
npm run build
```
Launch Swordfish
```
electron .
```

## Update Swordfish
```
git -C /opt/Maxprograms/Swordfish/ pull
```
Or
```
cd /opt/Maxprograms/Swordfish && git pull
```
Or remove previous version and re-download current version. Make sure to rebuild current version.
```
sudo rm -r /opt/Maxprograms/Swordfish && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/Swordfish.git
```
Create shortcut for Gnome
```
cat << EOF >>  ~/.local/share/applications/swordfish.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Swordfish
Type=Application
Exec=electron /opt/Maxprograms/Swordfish
Icon=/opt/Maxprograms/Swordfish/icons/icon.png
Terminal=false
GenericName=Swordfish
Comment=Swordfish
Categories=Swordfish
EOF
```