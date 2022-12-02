# Package

Experimental package manager cross platform

### Build 

- Linux

```bash
dart compile exe ./bin/*.dart -o ./linux/package_managerdeb/usr/local/bin/package
dpkg-deb --build --root-owner-group ./linux/package_managerdeb ./package-linux.deb
sudo dpkg -i ./package-linux.deb
```