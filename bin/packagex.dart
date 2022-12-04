// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';

import 'package:packagex/packagex.dart';

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  Args args = Args(arguments);
  PackageBuild packageBuild = PackageBuild();
  if (arguments.isEmpty) {
    print(menu_help);
    exit(0);
  }
  String command = args.arguments[0];
  List<String> commands = ["create", "build"];
  if (!commands.contains(command)) {
    print(menu_help);
    exit(0);
  }
  if (command == "create") {
    try {
      String name = args.arguments[1];
      String path_project = p.join(Directory.current.path, name);
      await packageBuild.create(
        name: p.basename(path_project),
        package: p.basename(path_project),
      );
    } catch (e) {
      print(e);
    }
  }
  if (command == "build") {
    String? out = args["-output"];
    try {
      String path_project = p.join(Directory.current.path);
      await packageBuild.build(path: path_project, output: out);
    } catch (e) { 
      String path_project = p.join(Directory.current.path);
      await packageBuild.build(path: path_project, output: out);
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
