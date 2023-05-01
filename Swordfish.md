# [Swordfish IV](https://github.com/rmraya/Swordfish)
The following are steps to install Swordfish from source on Ubuntu 20.04

---

## Install software and build from source
Install required software.
```
sudo apt install openjdk-17-jdk git curl
sudo snap install ant --classic
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs
sudo npm install -g npm@latest
sudo apt install node-typescript
```

Check node.js and npm versions
```
node -v
npm -v
tsc -v
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
Build Swordfish.
```
ant
sudo npm install -g electron --unsafe-perm=true --allow-root --no-fund
npm install --no-fund
npm run build
```
Run *npm start* to test if Swordfish will launch.
```
npm start
```
## Create desktop shortcut
Install electron into Swordfish folder and launch Swordfish.
```
cd /opt/Maxprograms/Swordfish
sudo npm install -g electron --unsafe-perm=true --allow-root
electron .
```
Create shortcut for Gnome.
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

## Update Swordfish
```
git -C /opt/Maxprograms/Swordfish/ pull
```
Or
```
cd /opt/Maxprograms/Swordfish && git pull
```
Or remove previous version then re-download and rebuild current version.
```
sudo rm -r /opt/Maxprograms/Swordfish && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/Swordfish.git

cd /opt/Maxprograms/Swordfish
ant
npm install electron --save-dev --no-fund
npm run build
```
