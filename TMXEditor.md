# [TMXEditor](https://github.com/rmraya/TMXEditor)
The following are steps to install TMXEditor from source on Ubuntu 20.04

---

## Install software and build from source
Install required software.
```
sudo apt install openjdk-17-jdk git curl
sudo snap install ant --classic
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs
sudo npm install -g npm@latest
```

Check node.js and npm versions.
```
node -v
npm -v
```

Make folder and set permissions to install TMXEditor.
```
sudo mkdir -p /opt/Maxprograms/
sudo chmod 777 /opt/Maxprograms
```

Switch working directory and download TMXEditor from github.
```
cd /opt/Maxprograms/
git clone https://github.com/rmraya/TMXEditor.git
cd /opt/Maxprograms/TMXEditor
```

Build TMXEditor.
```
ant
sudo npm install -g electron --unsafe-perm=true --allow-root --no-fund
npm install --no-fund
npm run build
```
Run *npm start* to test if TMXEditor will launch.
```
npm start
```

## Create desktop shortcut
Install electron into TMXEditor folder and launch TMXEditor.
```
cd /opt/Maxprograms/TMXEditor
sudo npm install -g electron --unsafe-perm=true --allow-root
electron .
```

Create shortcut for Gnome.
```
cat << EOF >>  ~/.local/share/applications/tmxeditor.desktop
[Desktop Entry]
Encoding=UTF-8
Name=TMXEditor
Type=Application
Exec=electron /opt/Maxprograms/TMXEditor
Icon=/opt/Maxprograms/TMXEditor/icons/tmxeditor.png
Terminal=false
GenericName=TMXEditor
Comment=TMXEditor
Categories=TMXEditor
EOF
```

## Update TMXEditor
```
git -C /opt/Maxprograms/TMXEditor/ pull
```
Or
```
cd /opt/Maxprograms/TMXEditor && git pull
```
Or remove previous version and re-download current version. Make sure to rebuild current version.
```
sudo rm -r /opt/Maxprograms/TMXEditor && cd /opt/Maxprograms/ && git clone https://github.com/rmraya/TMXEditor.git
cd /opt/Maxprograms/TMXEditor
ant
npm install electron --save-dev --no-fund
npm run build
```

## Fix npm warnings
```
npm install @npmcli/move-file
npm install @npmcli/fs
```

