// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps

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
    double version = 0.0,
    String architecture = "amd64",
    String essential = "no",
    String description = "A new Flutter project.",
    String homepage = "https://youtube.com/@azkadev",
  }) async {
    if (Platform.isLinux) {
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
      List<List<String>> folders = [
        ["DEBIAN"],
        ["usr", "lib"],
        ["usr", "local"],
        ["usr", "local", "bin"],
        ["usr", "local", "lib"],
        ["usr", "local", "share", package],
      ];
      for (var i = 0; i < folders.length; i++) {
        List<String> res = folders[i];
        Directory dir = Directory(p.joinAll([directory.path, ...res]));
        await dir.autoCreate();
      }
      await File(p.join(directory.path, "DEBIAN", "control")).writeAsString(scripts);
      return;
    }
  }

  Future build({
    required String path,
    String? output,
  }) async {
    if (Platform.isLinux) {
      output ??= p.join(Directory.current.path, "${p.basename(path)}.deb");
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
