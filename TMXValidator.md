# TMXValidator
The following are steps to install TMXValidator from source on Ubuntu 20.04

---

## Install software and build from source
Install required software.
```
sudo apt install openjdk-17-jdk git
sudo snap install ant --classic
sudo snap install node --classic
```
Make folder and set permissions to install TMXValidator.
```
sudo mkdir -p /opt/Maxprograms/
sudo chmod 777 /opt/Maxprograms
```
Switch working directory and download TMXValidator from github.
```
cd /opt/Maxprograms/
git clone https://github.com/rmraya/TMXValidator.git
cd /opt/Maxprograms/TMXValidator
```
Build TMXEditor.
```
ant
sudo npm install -g electron --unsafe-perm=true --allow-root
npm install
npm run build
```
Run *npm start* to test if TMXValidator will launch.
```
npm start
```
## Create desktop shortcut
Install electron into TMXValidator folder and launch TMXValidator.
```
cd /opt/Maxprograms/tmxvalidator
sudo npm install -g electron --unsafe-perm=true --allow-root
electron .
```
Create shortcut for Gnome.
```
cat << EOF >>  ~/.local/share/applications/tmxvalidator.desktop
[Desktop Entry]
Encoding=UTF-8
Name=TMXEditor
Type=Application
Exec=electron /opt/Maxprograms/TMXValidator
Icon=/opt/Maxprograms/TMXEditor/icons/tmxvalidator.png
Terminal=false
GenericName=TMXEditor
Comment=TMXEditor
Categories=TMXEditor
EOF
```

## Update Swordfish
```
cp -r /opt/Maxprograms/TMXValidator /opt/Maxprograms/TMXValidator.bak.$(date "+%Y.%m.%d")
git -C /opt/Maxprograms/TMXValidator/ reset --hard
git -C /opt/Maxprograms/TMXValidator/ pull
```
Or
```
cd /opt/Maxprograms/TMXValidator && git pull
```
Or remove previous version and re-download current version. Make sure to rebuild current version.
```
sudo rm -r /opt/Maxprograms/TMXValidator && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/TMXValidator.git
```
