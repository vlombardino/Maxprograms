# [Swordfish IV](https://github.com/rmraya/Swordfish)
The following are steps to install Swordfish from source on Ubuntu 24.04

---

## Install software and build from source
Install required software.
```
sudo apt install openjdk-21-jdk git curl
sudo snap install ant --classic
sudo snap install node --classic
npm install typescript --save-dev
```

Check installed versions
```
java --version
node -v
npm -v
npx tsc --version
```
> or run one command to show all installed versions.
```
java --version && ant -version && printf "Node.js version: %s\n" "$(node -v)" && printf "npm version: %s\n" "$(npm -v)" && printf "TypeScript version: %s\n" "$(npx tsc --version)"
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
npm install electron --save-dev --no-fund
npm run build
sudo npm install -g electron --unsafe-perm=true --allow-root
```
Run *npm start* to test if Swordfish will launch.
```
npm start
```
## Create desktop shortcut
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
cp -r /opt/Maxprograms/Swordfish /opt/Maxprograms/Swordfish.bak.$(date "+%Y.%m.%d")
git -C /opt/Maxprograms/Swordfish/ reset --hard
git -C /opt/Maxprograms/Swordfish/ pull
```
Or
```
cd /opt/Maxprograms/Swordfish && git pull
```
Or backup previous version then re-download and rebuild current version.
```
sudo mv /opt/Maxprograms/Swordfish /opt/Maxprograms/Swordfish.bak.$(date "+%Y.%m.%d") && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/Swordfish.git

cd /opt/Maxprograms/Swordfish
ant
npm install electron --save-dev --no-fund
npm run build
sudo npm install -g electron --unsafe-perm=true --allow-root
```
Or remove previous version then re-download and rebuild current version.
```
sudo rm -r /opt/Maxprograms/Swordfish && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/Swordfish.git

cd /opt/Maxprograms/Swordfish
ant
npm install electron --save-dev --no-fund
npm run build
sudo npm install -g electron --unsafe-perm=true --allow-root
```
