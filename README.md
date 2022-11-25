# Package

Experimental package manager cross platform

### Build 

```bash
dart compile exe ./bin/*.dart -o ./linux/package/deb/usr/local/bin/package
dpkg-deb --build --root-owner-group ./linux/package/deb
sudo dpkg -i ./linux/package/deb.deb
```