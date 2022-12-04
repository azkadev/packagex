// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element

library packagex;

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
    String scripts = """
Maintainer: "${maintaner}"
Package: ${package}
Version: ${version}
Priority: optional
Architecture: amd64
Essential: no
Description: "${description}"
Homepage: "${homepage}"
""";
    Directory directory = Directory(p.join(Directory.current.path, name));
    await directory.create(recursive: true);

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
          await File(p.join(directory.path, "DEBIAN", "control")).writeAsString(scripts);
        } catch (e) {}
      }
      return;
    }

    Process shell = await Process.start(
      "dart",
      ["create", name, (isForce) ? "--force" : ""],
    );
    await stdout.addStream(shell.stdout);
    await stderr.addStream(shell.stderr);

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
    Directory directory = Directory(p.join(Directory.current.path, "build"));
    await directory.autoCreate();
    if (Platform.isLinux) {
      output ??= p.join(directory.path, "${p.basename(path)}-linux.deb");
      path = p.join(path, "linux", "packaging"); 
      Process shell = await Process.start(
        "dpkg-deb",
        [
          "--build",
          "--root-owner-group",
          path,
          output,
        ],
      );
      stdout.addStream(shell.stdout);
      stderr.addStream(shell.stderr);
    }
    return;
  }
}
