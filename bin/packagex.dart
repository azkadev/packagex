// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';

import 'package:packagex/packagex.dart';

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  Args args = Args(arguments);
  PackageBuild packageBuild = PackageBuild();
  PackageX packageX = PackageX();
  if (arguments.isEmpty) {
    print(menu_help);
    exit(0);
  }
  String command = args.arguments[0];
  List<String> commands = [
    "create",
    "build",
    "bundle",
    "install",
    "version",
    "uninstall",
    "publish",
  ];
  if (!commands.contains(command)) {
    print(menu_help);
    exit(0);
  }
  if (command == "version") {
    print("v0.0.9-dev");
    exit(0);
  }
  if (command == "create") {
    try {
      String name = args.arguments[1];
      String path_project = p.join(Directory.current.path, name);
      await packageBuild.create(
        name: p.basename(path_project),
        package: p.basename(path_project),
        isForce: args.arguments.contains("--force"),
      );
    } catch (e) {
      print(e);
    }
  }
  if (command == "build") {
    String? out;
    List<String> outputs = [
      "-output",
      "-o",
    ];
    for (var i = 0; i < outputs.length; i++) {
      var loop_data = outputs[i];
      if (args[loop_data] != null) {
        out = args[loop_data] ?? "";
      }
    }
    try {
      String path_project = p.join(Directory.current.path);
      await packageBuild.build(
        path: path_project,
        output: out,
      );
    } catch (e) {
      String path_project = p.join(Directory.current.path);
      await packageBuild.build(
        path: path_project,
        output: out,
      );
    }
  }
  if (command == "install") {
    String package_name = args.arguments[1];

    if (RegExp(r"^http(s)?:\/\/.*$", caseSensitive: false).hashData(package_name)) {
      await packageX.installPackageFromUrl(url: package_name);
    } else {
      File file = File(package_name);
      if (file.existsSync()) {
        await packageX.installPackageFromFile(file: file);
      } else {
        // Platform.pathSeparator;

        await packageX.installPackage(
          name_package: package_name,
        );
      }
    }
  }
}

String menu_help = """
A command-line Package.

Usage: packagex <command> [arguments]

Global options:
help                 Print this usage information

Available commands: 
  create Create New Package
  build Build package to platform
  install (name/url/local_file) install package

Run "packagex help <command>" for more information about a command.

See https://youtube.com/@azkadev for detailed documentation and tutorial.
""";

String help_create = """
Create a new Packagex project.

Usage: packagex create name [arguments]

Available Arguments:
--force  Force project generation, even if the target directory already exists.

Run "packagex help" to see global options.
""";

String help_build = """
Create a new Packagex project.

Usage: packagex create name [arguments]

Available Arguments:
--force  Force project generation, even if the target directory already exists.

Run "packagex help" to see global options.
""";
