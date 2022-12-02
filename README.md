# Packagex

Experimental Packagex all in one for cross platform except web, pluggable support cli

<!-- - Linux

```bash
dart compile exe ./bin/*.dart -o ./linux/package_managerdeb/usr/local/bin/package
dpkg-deb --build --root-owner-group ./linux/package_managerdeb ./package-linux.deb
sudo dpkg -i ./package-linux.deb
``` -->


```bash
dart pub global activate packagex
```


## Create Package

```bash
packagex create name_project
```

## Build Package

```bash
packagex build name_project
```