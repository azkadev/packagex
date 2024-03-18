// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations

library packagex;

import "dart:async";
import 'dart:convert';
import "dart:io";
import "package:general_lib/scheme/json_dart.dart";
import "package:github/github.dart";
import "package:http/http.dart";
import "package:mime/mime.dart";
import "package:universal_io/io.dart";

import 'package:general_lib/general_lib.dart';
import 'package:path/path.dart' as p;
import "extension/directory.dart";
import "scheme/scheme.dart" as packagex_scheme;
import "package:yaml/yaml.dart" as yaml;
import "shell/shell.dart" as packagex_shell;
import "api/api.dart" as packagex_api;

import "package:collection/collection.dart";

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

extension ListExtensions on List<PackagexPlatform> {
  PackagexPlatform? getByString(String data) {
    for (var i = 0; i < length; i++) {
      try {
        if ((this[i]).name == data) {
          return (this[i]);
        }
      } catch (e) {}
    }
    return null;
  }
}

class Packagex {
  Packagex();

  Future<Map> request({
    required Map jsonData,
  }) async {
    JsonDart jsonDart = JsonDart(jsonData);

    if (RegExp(r"^(createPackage)$", caseSensitive: false).hashData(jsonDart["@type"])) {}
    if (RegExp(r"^(buildPackage)$", caseSensitive: false).hashData(jsonDart["@type"])) {
      packagex_api.BuildPackage buildPackage = packagex_api.BuildPackage(jsonData);

      return await build(
        packagexPlatform: (PackagexPlatform.values.getByString(buildPackage.platform ?? "current") as PackagexPlatform),
        path_current: buildPackage.path_current,
        packagexConfig: packagex_scheme.Packagex(
          buildPackage.build_config.rawData,
        ),
      );
    }

    return {
      "@type": "error",
      "message": "method_not_found",
      "description": "Method not found",
    };
  }

  Future<Map> clean({
    String? path_current,
  }) async {
    path_current ??= Directory.current.path;
    Directory directory_package = Directory(path_current);
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
    return {
      "@type": "ok",
    };
  }

  Future<Map> create({
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
      Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
      pubspec.rawData = yaml_code.clone();
    } else {
      await packagex_shell.shell(
        executable: "dart",
        arguments: [
          "create",
          name,
          "--force",
          "--no-pub",
        ],
        workingDirectory: Directory.current.path,
        runInShell: true,
        onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
      );

      while (true) {
        await Future.delayed(Duration(microseconds: 1));
        if (file_pubspec.existsSync()) {
          Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
          pubspec.rawData = yaml_code.clone();
          break;
        }
      }
    }
    if (pubspec["name"] == null) {
      pubspec["name"] = package_name;
    }
    if (pubspec["packagex"] is Map == false) {
      await file_pubspec.writeAsString("""

packagex:
  name: ${pubspec.name}
  dart_target: ${pubspec.name}
  flutter_target: main
  dart_name: ${pubspec.name}
  flutter_name: ${pubspec.name}
  is_without_platform_name: true
  flutter_commands:
    obfuscate: true
    split-debug-info: 0.0.5
    build-name: 0.0.5
    build-number: 40
    split-per-abi: true
    no-tree-shake-icons: false

  project_id: "azkadev.packagex"
  github_username: azkadev
  github_is_org: false
  
""", mode: FileMode.writeOnlyAppend);
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
        onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
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
Architecture: {{architecture_os}}
Essential: no
Installed-Size: 0
Description: "${pubspec.description}"
Homepage: "${pubspec.homepage}"
"""
        .replaceAllMapped(RegExp(r"({{architecture_os}})", caseSensitive: false), (match) {
      if (Platform.isAndroid) {
        return "all";
      } else {
        return "all";
      }
    });
    String app_desktop_linux = """
[Desktop Entry]
Type=Application
Version=0.0.0
Name=${package_name}
GenericName=General Application
Exec=${package_name} -- %u
Categories=Music;Media;
Keywords=Hello;World;Test;Application;
StartupNotify=true

""";
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
        await File(p.join(directory.path, ".gitignore")).writeAsString("""
usr/bin/${pubspec.name}
usr/share/${pubspec.name}
usr/local/bin/${pubspec.name}
usr/local/share/${pubspec.name}
""");
      } catch (e) {}
      try {
        await File(p.join(directory.path, "usr", "share", "applications", "${package_name}.desktop")).writeAsString(app_desktop_linux);
      } catch (e) {}

      return;
    }

    if (!directory_package.existsSync()) {
      await directory_package.create(recursive: true);
    }

    await createFolders(
      directory: Directory(p.join(directory_package.path, "android", "packagex")),
      folders: [
        ["DEBIAN"],
        ["usr", "bin"],
        ["usr", "lib"],
        ["usr", "local"],
        ["usr", "local", "bin"],
        ["usr", "local", "lib"],
        ["usr", "share", "applications"],
        ["usr", "share", pubspec.name!],
      ],
    );
    await createFolders(
      directory: Directory(p.join(directory_package.path, "ios", "packagex")),
      folders: [],
    );

    await createFolders(
      directory: Directory(p.join(directory_package.path, "linux", "packagex")),
      folders: [
        ["DEBIAN"],
        ["usr", "bin"],
        ["usr", "lib"],
        ["usr", "local"],
        ["usr", "local", "bin"],
        ["usr", "local", "lib"],
        ["usr", "share", "applications"],
        ["usr", "share", pubspec.name!],
      ],
    );
    await createFolders(
      directory: Directory(p.join(directory_package.path, "macos", "packagex")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory_package.path, "windows", "packagex")),
      folders: [],
    );

    if (Platform.isAndroid) {
      await packagex_shell.shell(
        executable: "chmod",
        arguments: [
          "775",
          p.join(directory_package.path, "android", "packagex", "DEBIAN", "postinst"),
        ],
        runInShell: true,
        onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
      );
      await packagex_shell.shell(
        executable: "chmod",
        arguments: [
          "775",
          p.join(directory_package.path, "android", "packagex", "DEBIAN", "postrm"),
        ],
        runInShell: true,
        onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
      );
    }

    if (Platform.isLinux) {
      await packagex_shell.shell(
        executable: "chmod",
        arguments: [
          "775",
          p.join(directory_package.path, "linux", "packagex", "DEBIAN", "postinst"),
        ],
        runInShell: true,
        onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
      );
      await packagex_shell.shell(
        executable: "chmod",
        arguments: [
          "775",
          p.join(directory_package.path, "linux", "packagex", "DEBIAN", "postrm"),
        ],
        runInShell: true,
        onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
      );
    }

    return {};
  }

  Future<Map> build({
    PackagexPlatform? packagexPlatform,
    required String? path_current,
    String? path_output,
    String? name_output,
    packagex_scheme.Packagex? packagexConfig,
    bool cancelOnError = false,
  }) async {
    path_current ??= Directory.current.path;
    packagexConfig ??= packagex_scheme.Packagex({});
    packagexPlatform ??= PackagexPlatform.current;
    if (packagexPlatform == PackagexPlatform.current) {
      if (Platform.isLinux) {
        packagexPlatform = PackagexPlatform.linux;
      }
      if (Platform.isMacOS) {
        packagexPlatform = PackagexPlatform.macos;
      }
      if (Platform.isAndroid) {
        packagexPlatform = PackagexPlatform.android;
      }
      if (Platform.isWindows) {
        packagexPlatform = PackagexPlatform.windows;
      }
    }
    String basename = p.basename(path_current);
    Directory directory_current = Directory(path_current);

    File file_pubspec = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);

    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec(yaml_code.clone());
    if (pubspec["name"] == null) {
      pubspec["name"] = basename;
    }
    if (pubspec["packagex"] is Map == false) {
      pubspec["packagex"] = {};
    }

    packagexConfig.rawData.forEach((key, value) {
      if (value != null) {
        pubspec["msix_config"][key.toString()] = value;
        pubspec["packagex"][key.toString()] = value;
      }
    });
    File script_cli = File(p.join(directory_current.path, "bin", "${pubspec.packagex.dart_target ?? pubspec.name}.dart"));
    File script_app = File(p.join(directory_current.path, "lib", "${pubspec.packagex.flutter_target ?? "main"}.dart"));
    bool is_app = false;
    bool is_cli = false;
    if (script_app.existsSync()) {
      is_app = true;
    }
    if (script_cli.existsSync()) {
      is_cli = true;
    }

    List<String> flutter_commands = [];

    pubspec.packagex.flutter_commands.rawData.forEach((key, value) {
      String key_args_flutter = "--${key.toString().replaceAll(RegExp(r"_"), "-")}";
       if (key_args_flutter == "--obfuscate") {
        if (value == true) {
          flutter_commands.add(key_args_flutter);
        }
      }
      if (key_args_flutter == "--split-per-abi") {
        if (value == true) {
          flutter_commands.add(key_args_flutter);
        }
      }
      if (key_args_flutter == "--no-tree-shake-icons") {
        if (value == true) {
          flutter_commands.add(key_args_flutter);
        }
      }

      if (key_args_flutter == "--split-debug-info") {
        flutter_commands.add("${key_args_flutter}=${value}");
      }
      if (key_args_flutter == "--build-name") {
        flutter_commands.add("${key_args_flutter}=${value}");
      }
      if (key_args_flutter == "--build-number") {
        flutter_commands.add("${key_args_flutter}");
        flutter_commands.add("${value}");
      }
    }); 

    Directory directory_build_packagex = Directory(path_output ?? p.join(directory_current.path, "build", "packagex"));
    await directory_build_packagex.autoCreate();

    if (packagexPlatform == PackagexPlatform.linux) {
      if (!Platform.isLinux) {
        return {
          "@type": "error",
          "message": "platform_not_supported",
          "description": "Package linux hanya bisa di perangkat linux saja !",
        };
      }

      String path_linux_package = p.join(
        path_current,
        "linux",
        "packagex",
      );

      String path_app_deb = p.join(
        path_linux_package,
        "usr",
        "share",
        pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
      );

      try {
        await packagex_shell.shell(
          executable: "chmod",
          arguments: ["775", p.join(path_linux_package, "DEBIAN", "postinst")],
          runInShell: true,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
      } catch (e) {}
      try {
        await packagex_shell.shell(
          executable: "chmod",
          arguments: ["775", p.join(path_linux_package, "DEBIAN", "postrm")],
          runInShell: true,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
      } catch (e) {}

      if (is_app) {
        try {
          if (Directory(path_app_deb).existsSync()) {
            await Directory(path_app_deb).delete(recursive: true);
            await Directory(path_app_deb).create(recursive: true);
          } else {
            await Directory(path_app_deb).create(recursive: true);
          }
        } catch (e) {}
      }
      File file_cli = File(p.join(
        path_linux_package,
        "usr",
        "bin",
        "${pubspec.packagex.dart_name ?? pubspec.name!.replaceAll(RegExp(r"([_])"), "-")}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-cli-linux"}",
      ));
      File file_app = File(p.join(directory_build_packagex.path, "${pubspec.packagex.flutter_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-linux"}.deb"));

      if (is_cli) {
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
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["775", file_cli.path],
            runInShell: true,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        } catch (e) {}
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "linux",
            "--release",
            "--target=${script_app.path}",
            ...flutter_commands,
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
        String path_app = p.join(directory_current.path, "build", "linux", "x64", "release", "bundle", ".");
        await packagex_shell.shell(
          executable: "cp",
          arguments: [
            "-rf",
            path_app,
            path_app_deb,
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
      }

      if (is_app || is_cli) {
        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["-R", "775", path_linux_package],
            runInShell: true,
            workingDirectory: directory_current.path,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        } catch (e) {}
        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["-R", "775", path_linux_package],
            workingDirectory: directory_current.path,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        } catch (e) {}
        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            file_app.path,
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
        try {
          if (file_cli.existsSync()) {
            await file_cli.delete(recursive: true);
          }
        } catch (e) {}
      }
    } else if (packagexPlatform == PackagexPlatform.windows) {
      if (!Platform.isWindows) {
        return {"@type": "error", "message": "platform_not_supported", "description": "Package windows hanya bisa di perangkat windows saja !"};
      }
      // output ??= p.join(directory_build_packagex.path, );
      if (!pubspec.dev_dependencies.rawData.containsKey("msix")) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: ["pub", "add", "--dev", "msix"],
          workingDirectory: directory_current.path,
          runInShell: true,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
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
            p.join(directory_build_packagex.path, "${pubspec.packagex.dart_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-cli-windows"}.exe"),
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
      }

      if (is_app) {
        List<String> args_msix = [];
        List<String> msix_args = [
          "--display-name",
          "--publisher-display-name",
          "--identity-name",
          "--version",
          "--logo-path",
          "--trim-logo",
          "--capabilities",
          "--languages",
          "--file-extension",
          "--protocol-activation",
          "--app-uri-handler-hosts",
          "--execution-alias",
          "--enable-at-startup",
          "--store",
          "--certificate-path",
          "--certificate-password",
          "--publisher",
          "--signtool-options",
          "--sign-msix",
          "--install-certificate",
        ];
        pubspec.msix_config.rawData.forEach((key, value) {
          if (value is String && value.isNotEmpty) {
            String key_args_msix = "--${key.toString().replaceAll(RegExp(r"_"), "-")}";
            if (!msix_args.contains(key_args_msix)) {
              return;
            }
            if (key_args_msix == "--version") {
              List<String> versions = value.toString().split(".");
              if (versions.length != 4) {
                value = "0.0.0.0";
              }
            }
            args_msix.add(key_args_msix);
            args_msix.add(value);
          }
        });

        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "pub",
            "run",
            "msix:create",
            "--windows-build-args",
            "--target=${script_app.path} ${flutter_commands.join(" ")}",
            "-o",
            directory_build_packagex.path,
            "-n",
            "${pubspec.packagex.flutter_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-app-windows"}",
            ...args_msix,
          ],
          workingDirectory: directory_current.path,
          runInShell: true,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
      }
    } else if (packagexPlatform == PackagexPlatform.macos) {
      if (!Platform.isMacOS) {
        return {"@type": "error", "message": "platform_not_supported", "description": "Package macos hanya bisa di perangkat macos saja !"};
      }
      if (is_cli) {
        await packagex_shell.shell(
          executable: "dart",
          arguments: [
            "compile",
            "exe",
            script_cli.path,
            "-o",
            p.join(directory_build_packagex.path, "${pubspec.packagex.dart_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-cli-macos"}"),
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "macos",
            "--release",
            "--target=${script_app.path}",
            ...flutter_commands,
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
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
            "--target=${script_app.path}",
            ...flutter_commands,
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
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
              await dir.absolute.copy(p.join(directory_build_packagex.path, p.basename(dir.path).replaceAll(RegExp("^(app)", caseSensitive: false), "${pubspec.packagex.flutter_name ?? pubspec.name}")));
            }
          } catch (e) {}
        }
      }

      if (is_cli) {
        if (!Platform.isAndroid) {
          return {
            "@type": "error",
            "message": "platform_not_supported",
            "description": "Package Android hanya bisa di perangkat android saja !",
          };
        }

        String path_android_package = p.join(
          path_current,
          "android",
          "packagex",
        );

        String path_app_deb = p.join(
          path_android_package,
          "usr",
          "share",
          pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
        );

        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["775", p.join(path_android_package, "DEBIAN", "postinst")],
            runInShell: true,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        } catch (e) {}
        try {
          await packagex_shell.shell(
            executable: "chmod",
            arguments: ["775", p.join(path_android_package, "DEBIAN", "postrm")],
            runInShell: true,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        } catch (e) {}

        if (is_app) {
          try {
            if (Directory(path_app_deb).existsSync()) {
              await Directory(path_app_deb).delete(recursive: true);
              await Directory(path_app_deb).create(recursive: true);
            } else {
              await Directory(path_app_deb).create(recursive: true);
            }
          } catch (e) {}
        }
        File file_cli = File(p.join(
          path_android_package,
          "usr",
          "bin",
          "${pubspec.packagex.dart_name ?? pubspec.name!.replaceAll(RegExp(r"([_])"), "-")}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-cli-android"}",
        ));
        File file_app = File(p.join(directory_build_packagex.path, "${pubspec.packagex.flutter_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-android"}.deb"));

        if (is_cli) {
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
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );

          try {
            await packagex_shell.shell(
              executable: "chmod",
              arguments: ["775", file_cli.path],
              workingDirectory: directory_current.path,
              onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stdout.add(data);
              },
              onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stderr.add(data);
              },
            );
          } catch (e) {}
          try {
            await packagex_shell.shell(
              executable: "chmod",
              arguments: ["775", file_cli.path],
              runInShell: true,
              workingDirectory: directory_current.path,
              onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stdout.add(data);
              },
              onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stderr.add(data);
              },
            );
          } catch (e) {}
        }

        if (is_app) {
          // await packagex_shell.shell(
          //   executable: "flutter",
          //   arguments: [
          //     "build",
          //     "linux",
          //     "--release",
          //     "--target=${script_app.path}",
          //     ...flutter_commands,
          //   ],
          //   workingDirectory: directory_current.path,
          //   onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          //     stdout.add(data);
          //   },
          //   onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          //     stderr.add(data);
          //   },
          // );
          // String path_app = p.join(directory_current.path, "build", "android", "x64", "release", "bundle", ".");
          // await packagex_shell.shell(
          //   executable: "cp",
          //   arguments: [
          //     "-rf",
          //     path_app,
          //     path_app_deb,
          //   ],
          //   workingDirectory: directory_current.path,
          //   onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          //     stdout.add(data);
          //   },
          //   onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
          //     stderr.add(data);
          //   },
          // );
        }

        if (is_app || is_cli) {
          try {
            await packagex_shell.shell(
              executable: "chmod",
              arguments: ["-R", "775", path_android_package],
              runInShell: true,
              workingDirectory: directory_current.path,
              onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stdout.add(data);
              },
              onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stderr.add(data);
              },
            );
          } catch (e) {}
          try {
            await packagex_shell.shell(
              executable: "chmod",
              arguments: ["-R", "775", path_android_package],
              workingDirectory: directory_current.path,
              onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stdout.add(data);
              },
              onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
                stderr.add(data);
              },
            );
          } catch (e) {}
          await packagex_shell.shell(
            executable: "dpkg-deb",
            arguments: [
              "--build",
              "--root-owner-group",
              path_android_package,
              file_app.path,
            ],
            workingDirectory: directory_current.path,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
          try {
            if (file_cli.existsSync()) {
              await file_cli.delete(recursive: true);
            }
          } catch (e) {}
        }
      }
    } else if (packagexPlatform == PackagexPlatform.ios) {
      if (!Platform.isMacOS) {
        return {
          "@type": "error",
          "message": "platform_not_supported",
          "description": "Package ios hanya bisa di perangkat macos saja !",
        };
      }

      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "ios",
            "--release",
            "--no-codesign",
            "--target=${script_app.path}",
            ...flutter_commands,
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
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
zip -r  ${p.join(directory_build_packagex.path, "${pubspec.packagex.flutter_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-ios"}.ipa")} Payload
"""
          ],
          workingDirectory: directory_current.path,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
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
            "--target=${script_app.path}",
            "--web-renderer",
            "html",
          ],
          workingDirectory: directory_current.path,
          runInShell: true,
          onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stdout.add(data);
          },
          onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
            stderr.add(data);
          },
        );

        Directory directory_build_web_canvaskit = Directory(p.join(directory_current.path, "build", "web", "canvaskit", "."));

        try {
          await directory_build_web_canvaskit.delete(recursive: true);
        } catch (e) {}

        if (Platform.isWindows) {
          // zip
          await packagex_shell.shell(
            executable: "tar",
            arguments: ["-cf", p.join(directory_build_packagex.path, "${pubspec.packagex.flutter_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-web"}.zip"), "*"],
            workingDirectory: p.join(directory_current.path, "build", "web"),
            runInShell: true,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        }

        if (Platform.isMacOS || Platform.isLinux) {
          await packagex_shell.shell(
            executable: "zip",
            arguments: [
              "-r",
              p.join(directory_build_packagex.path, "${pubspec.packagex.flutter_name ?? pubspec.name}${(pubspec.packagex.is_without_platform_name == true) ? "" : "-web"}.zip"),
              ".",
            ],
            workingDirectory: p.join(directory_current.path, "build", "web", "."),
            runInShell: true,
            onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stdout.add(data);
            },
            onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
              stderr.add(data);
            },
          );
        }
      }
    }
    return {"@type": ""};
  }

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

  Future<void> publish({
    required String tokenGithub,
    String? path_current,
    String publishType = "stable",
    required FutureOr<dynamic> Function(String update) onUpdate,
  }) async {
    path_current ??= Directory.current.path;
    Directory directory_current = Directory(path_current);
    Directory directory_build = Directory(p.join(directory_current.path, "build"));
    Directory directory_packagex = Directory(p.join(directory_build.path, "packagex"));

    String basename = p.basename(path_current);

    File file_pubspec = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);

    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec(yaml_code.clone());
    if (pubspec["name"] == null) {
      pubspec["name"] = basename;
    }
    if (pubspec["packagex"] is Map == false) {
      pubspec["packagex"] = {};
    }
    String project_id = pubspec.packagex.project_id ?? "";
    String github_username = pubspec.packagex.github_username ?? "";
    GitHub gitHub = GitHub(auth: Authentication.withToken(tokenGithub));
    onUpdate("Check User");
    User user = await gitHub.users.getCurrentUser();
    onUpdate("Use Github: ${user.login}");
    RepositorySlug repositorySlug = RepositorySlug(github_username, project_id);

    List<FileSystemEntity> files = await Future(() async {
      return directory_packagex.listSync().where((e) => [".deb", ".apk", ".msix"].contains(p.extension(e.path))).where((element) {
        if (RegExp(pubspec.name ?? "", caseSensitive: false).hashData(element.path)) {
          return true;
        }
        return false;
      }).toList();
    });
    onUpdate("Upload List: ${files.length}");
    onUpdate("Fetch Repo: ${repositorySlug.fullName}");
    Repository repository = await Future(() async {
      try {
        return await gitHub.repositories.getRepository(
          repositorySlug,
        );
      } catch (e) {
        if (e is GitHubError) {
          if (RegExp(r"Repository not found", caseSensitive: false).hashData(e.message)) {
            onUpdate("Create Repo: ${repositorySlug.fullName}");
            return await gitHub.repositories.createRepository(
              CreateRepository(
                project_id,
                hasIssues: false,
                autoInit: true,
                gitignoreTemplate: "Dart",
                licenseTemplate: "MIT",
              ),
              org: (pubspec.packagex.github_is_org == true) ? github_username : null,
            );
          }
        }
        rethrow;
      }
    });

    onUpdate("Fetch Release: ${repositorySlug.fullName} ${publishType}");

    Release release_repo = await Future(() async {
      try {
        return await gitHub.repositories.getReleaseByTagName(
          repositorySlug,
          publishType,
        );
      } catch (e) {
        if (e is GitHubError) {
          if (RegExp(r"Release for tagName .* not found", caseSensitive: false).hasMatch(e.message ?? "")) {
            onUpdate("Create Release: ${repositorySlug.fullName} ${publishType}");
            return await gitHub.repositories.createRelease(repositorySlug, CreateRelease(publishType), getIfExists: true);
          }
        }

        rethrow;
      }
    });

    onUpdate("Fetch Assets");
    List<ReleaseAsset> releaseAssets = await gitHub.repositories.listReleaseAssets(repositorySlug, release_repo).toList();
    onUpdate("Succes Fetch Assets: ${releaseAssets.length}");
    for (var i = 0; i < files.length; i++) {
      FileSystemEntity fileSystemEntity = files[i];
      if (fileSystemEntity is File) {
        ReleaseAsset? releaseAsset = releaseAssets.firstWhereOrNull((element) => element.name == p.basename(fileSystemEntity.path));
        if (releaseAsset != null) {
          onUpdate("Delete Asset: ${releaseAsset.name}");
          await gitHub.repositories.deleteReleaseAsset(repositorySlug, releaseAsset);
        }
        onUpdate("Upload Asset: ${p.basename(fileSystemEntity.path)}");
        await gitHub.repositories.uploadReleaseAssets(
          Release(
            name: basename,
            htmlUrl: release_repo.htmlUrl,
            tarballUrl: release_repo.tarballUrl,
            uploadUrl: release_repo.uploadUrl,
            url: release_repo.url,
          ),
          {
            CreateReleaseAsset(
              name: p.basename(fileSystemEntity.path),
              contentType: lookupMimeType(fileSystemEntity.path) ?? "",
              assetData: fileSystemEntity.readAsBytesSync(),
            ),
          },
        );

        onUpdate("Succes Upload Asset: ${p.basename(fileSystemEntity.path)}");
      }
    }
    onUpdate("Finished");
  }

  Future<void> installPackageFromFile({
    required File file,
    required void Function(String data) onData,
    required void Function() onDone,
  }) async {
    await packagex_shell.shell(
      executable: "dpkg",
      arguments: [
        "--force-all",
        "-i",
        file.path,
      ],
      onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
        stdout.add(data);
        onData(utf8.decode(data));
      },
      onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
        stderr.add(data);
        onData(utf8.decode(data));
      },
    );
    onDone();
  }
}
