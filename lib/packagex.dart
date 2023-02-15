// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element, non_constant_identifier_names, empty_catches

library packagex;

import 'dart:convert';
import "package:universal_io/io.dart";

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;

import "extension/directory.dart";

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
          await File(p.join(directory.path, "DEBIAN", "control")).writeAsString(scripts);
        } catch (e) {}
        try {
          await File(p.join(directory.path, "usr", "local", "share", "applications", "${package_name}.desktop")).writeAsString(app_desktop_linux);
        } catch (e) {}
      }
      return;
    }

    Process shell = await Process.start(
      "dart",
      ["create", name, "--force", "--no-pub"],
    );
    // await stdout.addStream(shell.stdout);
    // await stderr.addStream(shell.stderr);
    shell.stdout.listen(
      (event) {
        stdout.write(utf8.decode(event));
      },
      onDone: () {
        shell.kill();
      },
      cancelOnError: true,
    );
    shell.stderr.listen(
      (event) {
        stderr.write(utf8.decode(event));
      },
      onDone: () {
        shell.kill();
      },
      cancelOnError: true,
    );
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

  Future<void> build({
    required String path,
    String? output,
  }) async {
    String basename = p.basename(path);
    String path_script = p.join(Directory.current.path, "bin", "${basename}.dart");

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
      shell.stdout.listen(
        (event) {
          stdout.write(utf8.decode(event));
        },
        onDone: () {
          shell.kill();
        },
        cancelOnError: true,
      );
      shell.stderr.listen(
        (event) {
          stderr.write(utf8.decode(event));
        },
        onDone: () {
          shell.kill();
        },
        cancelOnError: true,
      );
    }
    if (Platform.isMacOS) {}
    if (Platform.isWindows) {}
    return;
  }
}

class PackageX {
  PackageX();

  build() {}

  Future<void> installPackageFromUrl({
    required String url,
    Map<String, dynamic>? options,
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
    await installPackageFromFile(
      file: file,
      onData: onData,
      onDone: onDone
    );
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

  Future<void> installPackageFromFile({
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
  }
}
