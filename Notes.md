# Swordfish notes

## Swordfish IV
### Remove Swordfish.
```
sudo rm -r /opt/Maxprograms/Swordfish
sudo rm -r /usr/share/applications/swordfish.desktop
sudo rm -r /usr/bin/swordfish
sudo rm -r ~/.config/Swordfish
```

## Swordfish III
Swordfish config files
```
sudo rm -r ~/.maxprograms
```

Swordfish java log files
```
sudo rm -r ~/.oracle_jre_usage
```

License Key
```
sudo rm -r ~/.audio/snddrivr.msa
```
---

## TMX files
### Find all tmx files and move to differenct location.
```
find . -type f -name "*.tmx" -exec cp {} /tmp/TMX \;
```
### Merege TMX files.
> TMXEditor -> File -> Merge TMX Files...

---

## Misc

### FixLicense.jar
```
java –jar FixLicense.jar
```
