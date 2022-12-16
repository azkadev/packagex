// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element, non_constant_identifier_names, empty_catches

library packagex;

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

part "extension/directory.dart";

class PackageBuild {
  PackageBuild();

  Future create({
    required String name,
    String maintaner = "-",
    required String package,
    bool isForce = true,
    double version = 0.0,
    String architecture = "amd64",
    String essential = "no",
    String description = "A new Flutter project.",
    String homepage = "https://youtube.com/@azkadev",
  }) async {
    String package_name = "";
    if (package != ".") {
      package_name = package;
    } else {
      package_name = p.basename(Directory.current.path);
    }

    String scripts = """
Maintainer: "${maintaner}"
Package: ${package_name}
Version: ${version}
Priority: optional
Architecture: amd64
Essential: no
Description: "${description}"
Homepage: "${homepage}"
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
      // List<List<String>> folders = [
      //   ["DEBIAN"],
      //   ["usr", "lib"],
      //   ["usr", "local"],
      //   ["usr", "local", "bin"],
      //   ["usr", "local", "lib"],
      //   ["usr", "local", "share", package],
      // ];
      await directory.autoCreate();
      for (var i = 0; i < folders.length; i++) {
        List<String> res = folders[i];
        Directory dir = Directory(p.joinAll([directory.path, ...res]));
        await dir.autoCreate();
      }
      if (Platform.isLinux) {
        try {
          await File(p.join(directory.path, "DEBIAN", "control"))
              .writeAsString(scripts);
        } catch (e) {}
        try {
          await File(p.join(directory.path, "usr", "local", "share",
                  "applications", "${package}.desktop"))
              .writeAsString(app_desktop_linux);
        } catch (e) {}
      }
      return;
    }

    Process shell = await Process.start(
      "dart",
      ["create", name, "--force", "--no-pub"],
    );
    await stdout.addStream(shell.stdout);
    // await stderr.addStream(shell.stderr);
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    await createFolders(
      directory: Directory(p.join(directory.path, "android", "packaging")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "ios", "packaging")),
      folders: [],
    );

    await createFolders(
      directory: Directory(p.join(directory.path, "linux", "packaging")),
      folders: [
        ["DEBIAN"],
        ["usr", "lib"],
        ["usr", "local"],
        ["usr", "local", "bin"],
        ["usr", "local", "lib"],
        ["usr", "local", "share", "applications"],
        ["usr", "local", "share", package],
      ],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "macos", "packaging")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "windows", "packaging")),
      folders: [],
    );

    return;
  }

  Future build({
    required String path,
    String? output,
  }) async {
    String basename = p.basename(path);
    String path_script =
        p.join(Directory.current.path, "bin", "${basename}.dart");

    Directory directory = Directory(p.join(Directory.current.path, "build"));

    await directory.autoCreate();
    if (Platform.isLinux) {
      output ??= p.join(directory.path, "${p.basename(path)}-linux.deb");
      path = p.join(path, "linux", "packaging");
      // Process compile = await Process.start(
      //   "dart",
      //   [
      //     "compile",
      //     "exe",
      //     path_script,
      //     "-o",
      //     p.join(path, "usr", "local", "bin", p.basename(basename)),
      //   ],
      // );
      // await Process.start(
      //   "dart",
      //   [
      //     "compile",
      //     "exe",
      //     path_script,
      //     "-o",
      //     p.join(path, "usr", "local", "share", p.basename(basename), p.basename(basename)),
      //   ],
      // );
      // compile.stdout.listen((event) {
      //   stdout.write(utf8.decode(event));
      // });
      // stdout.addStream(compile.stdout);
      Process shell = await Process.start(
        "dpkg-deb",
        [
          "--build",
          "--root-owner-group",
          path,
          output,
        ],
      );
      // stdout.addStream(shell.stdout);

      shell.stdout.listen((event) {
        stdout.write(utf8.decode(event));
      });
      stderr.addStream(shell.stderr);
    }
    return;
  }
}
