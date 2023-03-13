// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element, non_constant_identifier_names, empty_catches

library packagex;

import 'dart:convert';
import "package:universal_io/io.dart";

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;
// import "package:msix/msix.dart" as msix;
import "extension/directory.dart";
import "scheme/scheme.dart" as packagex_scheme;
import "package:yaml/yaml.dart" as yaml;
import "shell/shell.dart" as packagex_shell;

enum PackagexPlatform {
  current,
  android,
  ios,
  linux,
  macos,
  windows,
  web,
  all,
}

class PackageBuild {
  PackageBuild();

  Future<void> clean() async {
    Directory directory_package = Directory(p.join(Directory.current.path));
    void remove(Directory directory) {
      List<FileSystemEntity> dirs = directory.listSync();

      for (var i = 0; i < dirs.length; i++) {
        FileSystemEntity dir = dirs[i];
        if (dir is Directory) {
          try {
            String base_name = p.basename(dir.path);
            if (base_name == "packagex" || base_name == "packaging") {
              dir.deleteSync(
                recursive: true,
              );
            } else {
              remove(dir.absolute);
            }
          } catch (e) {}
        }
      }
    }

    remove(Directory.current);
    return;
  }

  Future<void> create({
    required String name,
  }) async {
    Directory directory_package = Directory(p.join(Directory.current.path, name));
    if (name == ".") {
      directory_package = Directory(p.join(Directory.current.path));
    }
    String package_name = p.basename(directory_package.path);
    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec({});
    File file_pubspec = File(p.join(directory_package.path, "pubspec.yaml"));
    if (file_pubspec.existsSync()) {
      try {
        Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
        pubspec.rawData = {...yaml_code};
      } catch (e) {}
    } else {
      await packagex_shell.shell(
        executable: "dart",
        arguments: [
          "create",
          name,
          "--force",
          "--no-pub",
        ],
        workingDirectory: directory_package.path,
        runInShell: true,
      );
    }
    if (pubspec["name"] == null) {
      pubspec["name"] = package_name;
    }
    if (pubspec["msix_config"] is Map == false) {
      await file_pubspec.writeAsString("""

msix_config: 
  display_name: ${pubspec.name}
  install_certificate: false
  # publisher_display_name: Azkadev
  # identity_name: org.azkadev.${package_name}
  # msix_version: 0.0.0.0
  # capabilities: internetClient, location, microphone, webcam
""", mode: FileMode.writeOnlyAppend);
    }

    if (!pubspec.dev_dependencies.rawData.containsKey("msix")) {
      await packagex_shell.shell(
        executable: "flutter",
        arguments: ["pub", "add", "--dev", "msix"],
        workingDirectory: directory_package.path,
        runInShell: true,
      );
    }

    if (pubspec["homepage"] == null) {
      pubspec["homepage"] = "https://github.com/azkadev";
    }

    package_name = package_name.toString().replaceAll(RegExp(r"([_])"), "-");
    String scripts = """
Maintainer: "${pubspec["maintaner"] ?? "azkadev"} <${pubspec["maintaner"] ?? "azkadev"}@noemail.com>"
Package: ${package_name}
Version: ${pubspec.version}
Section: x11
Priority: optional
Architecture: amd64
Essential: no
Installed-Size: 0
Description: "${pubspec.description}"
Homepage: "${pubspec.homepage}"
""";
    String app_desktop_linux = """
[Desktop Entry]
Type=Application
Version=0.0.0
Name=${package_name}
GenericName=General Application
Exec=${package_name} %U
Categories=Music;Media;
Keywords=Hello;World;Test;Application;
StartupNotify=true
""";
    Directory directory = Directory(p.join(Directory.current.path, name));
    Future<void> createFolders({
      required Directory directory,
      required List<List<String>> folders,
    }) async {
      await directory.autoCreate();
      for (var i = 0; i < folders.length; i++) {
        List<String> res = folders[i];
        Directory dir = Directory(p.joinAll([directory.path, ...res]));
        await dir.autoCreate();
      }
      try {
        await File(p.join(directory.path, "DEBIAN", "control")).writeAsString(scripts);
      } catch (e) {}
      try {
        await File(p.join(directory.path, "DEBIAN", "postinst")).writeAsString("""
#!/usr/bin/env sh
ln -s /usr/share/${package_name}/${pubspec.name!} /usr/bin/${package_name}
chmod +x /usr/bin/${package_name}
exit 0
""");
      } catch (e) {}
      try {
        await File(p.join(directory.path, "DEBIAN", "postrm")).writeAsString("""
#!/usr/bin/env sh
rm /usr/bin/${package_name} 
exit 0
""");
      } catch (e) {}
      try {
        await File(p.join(directory.path, "usr", "share", "applications", "${package_name}.desktop")).writeAsString(app_desktop_linux);
      } catch (e) {}

      return;
    }

    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    await createFolders(
      directory: Directory(p.join(directory.path, "android", "packagex")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "ios", "packagex")),
      folders: [],
    );

    await createFolders(
      directory: Directory(p.join(directory.path, "linux", "packagex")),
      folders: [
        ["DEBIAN"],
        ["usr", "lib"],
        ["usr", "local"],
        ["usr", "local", "bin"],
        ["usr", "local", "lib"],
        ["usr", "share", "applications"],
        ["usr", "share", pubspec.name!],
      ],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "macos", "packagex")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "windows", "packagex")),
      folders: [],
    );

    if (Platform.isLinux) {
      await packagex_shell.shell(
        executable: "chmod",
        arguments: ["775", p.join(directory.path, "linux", "packagex", "DEBIAN", "postinst")],
        runInShell: true,
      );
      await packagex_shell.shell(
        executable: "chmod",
        arguments: ["775", p.join(directory.path, "linux", "packagex", "DEBIAN", "postrm")],
        runInShell: true,
      );
    }

    return;
  }

  Future<void> build({
    required String path,
    String? output,
    PackagexPlatform? packagexPlatform,
  }) async {
    packagexPlatform ??= PackagexPlatform.current;

    if (packagexPlatform == PackagexPlatform.current) {
      if (Platform.isLinux) {
        packagexPlatform = PackagexPlatform.linux;
      }
      if (Platform.isMacOS) {
        packagexPlatform = PackagexPlatform.macos;
      }
      if (Platform.isWindows) {
        packagexPlatform = PackagexPlatform.windows;
      }
    }
    String basename = p.basename(path);
    Directory directory_current = Directory.current;
    File file_pubspec = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec(yaml_code);
    if (pubspec["name"] == null) {
      pubspec["name"] = basename;
    }
    File script_cli = File(p.join(directory_current.path, "bin", "${pubspec.name}.dart"));
    File script_app = File(p.join(directory_current.path, "lib", "main.dart"));
    bool is_app = false;
    bool is_cli = false;

    if (script_app.existsSync()) {
      is_app = true;
    }
    if (script_cli.existsSync()) {
      is_cli = true;
    }
    Directory directory_build_packagex = Directory(p.join(directory_current.path, "build", "packagex"));
    await directory_build_packagex.autoCreate();

    if (packagexPlatform == PackagexPlatform.linux) {
      if (!Platform.isLinux) {
        return;
      }
      output ??= p.join(directory_build_packagex.path, "${pubspec.name}-linux.deb");
      String path_linux_package = p.join(
        path,
        "linux",
        "packagex",
      );

      if (is_cli) {
        File file_cli = File(p.join(
          path_linux_package,
          "usr",
          "local",
          "bin",
          pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
        ));
        await packagex_shell.shell(
          executable: "dart",
          arguments: [
            "compile",
            "exe",
            script_cli.path,
            "-o",
            file_cli.path,
          ],
          workingDirectory: directory_current.path,
        );

        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["775", p.join(path_linux_package, "DEBIAN", "postinst")],
            runInShell: true,
          );
        } catch (e) {}
        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["775", p.join(path_linux_package, "DEBIAN", "postrm")],
            runInShell: true,
          );
        } catch (e) {}
        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            p.join(directory_build_packagex.path, "${pubspec.name}-cli-linux.deb"),
          ],
          workingDirectory: directory_current.path,
        );

        if (file_cli.existsSync()) {
          try {
            await file_cli.delete();
          } catch (e) {}
        }
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "linux",
            "--release",
          ],
          workingDirectory: directory_current.path,
        );
        String path_app = p.join(directory_current.path, "build", "linux", "x64", "release", "bundle", ".");
        String path_app_deb = p.join(
          path_linux_package,
          "usr",
          // "local",
          "share",
          pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
        );
        await packagex_shell.shell(
          executable: "cp",
          arguments: [
            "-rf",
            path_app,
            path_app_deb,
          ],
          workingDirectory: directory_current.path,
        );
        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            p.join(directory_build_packagex.path, "${pubspec.name}-app-linux.deb"),
          ],
          workingDirectory: directory_current.path,
        );
      }
    } else if (packagexPlatform == PackagexPlatform.windows) {
      if (!Platform.isWindows) {
        return;
      }
      // output ??= p.join(directory_build_packagex.path, );
      if (!pubspec.dev_dependencies.rawData.containsKey("msix")) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: ["pub", "add", "--dev", "msix"],
          workingDirectory: directory_current.path,
          runInShell: true,
        );
      }

      if (is_cli) {
        await packagex_shell.shell(
          executable: "dart",
          arguments: [
            "compile",
            "exe",
            script_cli.path,
            "-o",
            p.join(directory_build_packagex.path, "${pubspec.name}-cli-windows.exe"),
          ],
          workingDirectory: directory_current.path,
        );
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "pub",
            "run",
            "msix:create",
          ],
          workingDirectory: directory_current.path,
          runInShell: true,
        );

        await packagex_shell.shell(
          executable: "copy",
          arguments: [
            p.join(directory_current.path, "build", "windows", "runner", "Release", "${pubspec.name}.msix"),
            p.join(directory_build_packagex.path, "${pubspec.name}-app-windows.msix"),
          ],
          workingDirectory: directory_current.path,
          runInShell: true,
        );
      }
    } else if (packagexPlatform == PackagexPlatform.macos) {
      if (!Platform.isMacOS) {
        return;
      }
      if (is_cli) {
        await packagex_shell.shell(
          executable: "dart",
          arguments: [
            "compile",
            "exe",
            script_cli.path,
            "-o",
            p.join(directory_build_packagex.path, "${pubspec.name}-cli-macos"),
          ],
          workingDirectory: directory_current.path,
        );
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "macos",
            "--release",
          ],
          workingDirectory: directory_current.path,
        );
      }
    } else if (packagexPlatform == PackagexPlatform.android) {
      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "apk",
            "--release",
            "--split-per-abi",
          ],
          workingDirectory: directory_current.path,
        );

        Directory directory_apk = Directory(p.join(directory_current.path, "build", "app", "outputs", "flutter-apk"));
        List<FileSystemEntity> dirs = directory_apk.listSync();
        for (var i = 0; i < dirs.length; i++) {
          FileSystemEntity dir = dirs[i];
          try {
            if (dir is Directory) {
            } else if (dir is File) {
              if (p.extension(dir.path) != ".apk") {
                continue;
              }
              await dir.absolute.copy(
                p.join(
                  directory_build_packagex.path,
                  p.basename(
                    dir.path,
                  ),
                ),
              );
            }
          } catch (e) {}
        }
      }
    } else if (packagexPlatform == PackagexPlatform.ios) {
      if (!Platform.isMacOS) {
        return;
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "ios",
            "--release",
            "--no-codesign",
          ],
          workingDirectory: directory_current.path,
        );

        await packagex_shell.shell(
          executable: "sh",
          arguments: [
            "-c",
            """
cd build/ios/iphoneos
mkdir Payload
cd Payload
ln -s ../Runner.app
cd ..
zip -r  ${p.join(directory_build_packagex.path, "${pubspec.name}-ios.ipa")} Payload
"""
          ],
          workingDirectory: directory_current.path,
        );
      }
    } else if (packagexPlatform == PackagexPlatform.web) {
      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "web",
            "--release",
            "--web-renderer",
            "html",
          ],
          workingDirectory: directory_current.path,
          runInShell: true,
        );

        Directory directory_build_web_canvaskit = Directory(p.join(directory_current.path, "build", "web", "canvaskit", "."));

        try {
          await directory_build_web_canvaskit.delete(recursive: true);
        } catch (e) {}

        if (Platform.isWindows) {
          // zip
          await packagex_shell.shell(
            executable: "tar",
            arguments: ["-cf", p.join(directory_build_packagex.path, "${pubspec.name}-web.zip"), "*"],
            workingDirectory: p.join(directory_current.path, "build", "web"),
            runInShell: true,
          );
        }

        if (Platform.isMacOS || Platform.isLinux) {
          await packagex_shell.shell(
            executable: "zip",
            arguments: [
              "-r",
              p.join(directory_build_packagex.path, "${pubspec.name}-web.zip"),
              ".",
            ],
            workingDirectory: p.join(directory_current.path, "build", "web", "."),
            runInShell: true,
          );
        }
      }
    }
    return;
  }
}

class PackageX {
  PackageX();

  build() {}

  Future<void> installPackageFromUrl({
    required String url,
    FetchOption? options,
    Encoding? encoding,
    required void Function(String data) onData,
    required void Function() onDone,
  }) async {
    Response response = await fetch(
      url,
      options: options,
      encoding: encoding,
    );
    Directory directory = Directory(p.join(Directory.current.path, "package_temp"));
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    File file = File(p.join(directory.path, p.basename(url)));
    if (file.existsSync()) {
      await file.delete();
    }
    await file.writeAsBytes(response.bodyBytes);
    await installPackageFromFile(file: file, onData: onData, onDone: onDone);
  }

  Future<void> installPackage({
    required String name_package,
  }) async {
    String result_url_package = "";
  }

  Future<void> searchPackage({
    required String name_package,
  }) async {
    String result_url_package = "";
  }

  Future<void> listPackageByPublisher({
    required String username,
  }) async {
    String result_url_package = "";
  }

  Future<void> publishPackage({
    required String username,
  }) async {
    String result_url_package = "";
  }

  Future<Process> installPackageFromFile({
    required File file,
    required void Function(String data) onData,
    required void Function() onDone,
  }) async {
    Process shell = await Process.start(
      "dpkg",
      [
        "--force-all",
        "-i",
        file.path,
      ],
    );
    shell.stdout.listen(
      (event) {
        String data = utf8.decode(event);
        stdout.write(data);
        onData.call(data);
      },
      onDone: () {
        shell.kill();
        onDone.call();
      },
      cancelOnError: true,
    );
    shell.stderr.listen(
      (event) {
        String data = utf8.decode(event);
        stderr.write(data);
        onData.call(data);
      },
      onDone: () {
        shell.kill();
        onDone.call();
      },
      cancelOnError: true,
    );
    return shell;
  }
}
