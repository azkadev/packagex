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
}

class PackageBuild {
  PackageBuild();

  Future<void> create({
    required String name,
  }) async {
    Directory directory_package =
        Directory(p.join(Directory.current.path, name));
    if (name == ".") {
      directory_package = Directory(p.join(Directory.current.path));
    }
    String package_name = p.basename(directory_package.path);
    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec({});
    File file_pubspec = File(p.join(directory_package.path, "pubspec.yaml"));
    if (file_pubspec.existsSync()) {
      try {
        Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(),
            recover: true) as Map);
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
  publisher_display_name: Azkadev
  identity_name: org.azkadev.${package_name}
  msix_version: 0.0.0.0
  capabilities: internetClient, location, microphone, webcam
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

    if (pubspec["name"] != null) {
      pubspec["name"] =
          pubspec["name"].toString().replaceAll(RegExp(r"([_])"), "-");
    }

    if (pubspec["homepage"] == null) {
      pubspec["homepage"] = "https://github.com/azkadev";
    }

    package_name = package_name.toString().replaceAll(RegExp(r"([_])"), "-");
    String scripts = """
Maintainer: "${pubspec["maintaner"] ?? "azkadev"}"
Package: ${pubspec.name}
Version: ${pubspec.version}
Priority: optional
Architecture: amd64
Essential: no
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
        await File(p.join(directory.path, "DEBIAN", "control"))
            .writeAsString(scripts);
      } catch (e) {}
      try {
        await File(p.join(directory.path, "usr", "local", "share",
                "applications", "${package_name}.desktop"))
            .writeAsString(app_desktop_linux);
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
        ["usr", "local", "share", "applications"],
        ["usr", "local", "share", pubspec.name!],
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
    File file = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code =
        (yaml.loadYaml(file.readAsStringSync(), recover: true) as Map);
    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec(yaml_code);
    if (pubspec["name"] == null) {
      pubspec["name"] = basename;
    }
    File script_cli =
        File(p.join(directory_current.path, "bin", "${pubspec.name}.dart"));
    File script_app = File(p.join(directory_current.path, "lib", "main.dart"));
    bool is_app = false;
    bool is_cli = false;

    if (script_app.existsSync()) {
      is_app = true;
    }
    if (script_cli.existsSync()) {
      is_cli = true;
    }
    Directory directory =
        Directory(p.join(directory_current.path, "build", "packagex"));
    await directory.autoCreate();

    if (packagexPlatform == PackagexPlatform.linux) {
      output ??= p.join(directory.path, "${pubspec.name}-linux.deb");
      String path_linux_package = p.join(
        path,
        "linux",
        "packagex",
      );
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
        String path_app = p.join(directory_current.path, "build", "linux",
            "x64", "release", "bundle");
        await packagex_shell.shell(
          executable: "cp",
          arguments: [
            "-rf",
            path_app,
            p.join(
              path_linux_package,
              "usr",
              "local",
              "share",
              pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
            ),
          ],
          workingDirectory: directory_current.path,
        );
        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            p.join(directory.path, "${pubspec.name}-app-linux.deb"),
          ],
          workingDirectory: directory_current.path,
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
            p.join(
              path_linux_package,
              "usr",
              "local",
              "bin",
              pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
            ),
          ],
          workingDirectory: directory_current.path,
        );

        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            p.join(directory.path, "${pubspec.name}-cli-linux.deb"),
          ],
          workingDirectory: directory_current.path,
        );
      }
    } else if (packagexPlatform == PackagexPlatform.windows) {
      output ??= p.join(directory.path, "${pubspec.name}-app.msix");
      if (!pubspec.dev_dependencies.rawData.containsKey("msix")) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: ["pub", "add", "--dev", "msix"],
          workingDirectory: directory_current.path,
          runInShell: true,
        );
      }

      // await packagex_shell.shell(
      //   executable: "flutter",
      //   arguments: [
      //     "build",
      //     "windows",
      //     "--release",
      //   ],
      //   workingDirectory: directory_current.path,
      //   runInShell: true,
      // );

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
          p.join(directory_current.path, "build", "windows", "runner",
              "Release", "${pubspec.name}.msix"),
          output,
        ],
        workingDirectory: directory_current.path,
        runInShell: true,
      );
    } else if (packagexPlatform == PackagexPlatform.macos) {
    } else if (packagexPlatform == PackagexPlatform.android) {}
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
    Directory directory =
        Directory(p.join(Directory.current.path, "package_temp"));
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
