# Package

Experimental package manager cross platform

### Build 

- Linux

```bash
dart compile exe ./bin/*.dart -o ./linux/package/deb/usr/local/bin/package
dpkg-deb --build --root-owner-group ./linux/package/deb ./package-linux.deb
sudo dpkg -i ./package-linux.deb
```