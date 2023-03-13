// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:packagex/packagex.dart';

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;
import "package:yaml/yaml.dart" as yaml;
import "package:packagex/scheme/scheme.dart" as packagex_scheme;

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
    "read",
    "clean",
  ];
  if (!commands.contains(command)) {
    print(menu_help);
    exit(0);
  }
  if (command == "version") {
    print("v0.0.9-dev");
    exit(0);
  }
  if (command == "clean") {
    print("Start Clean");
    await packageBuild.clean();
    print("Complete Clean");
    return;
  }
  if (command == "create") {
    try {
      String name = args.arguments[1];
      String path_project = p.join(Directory.current.path, name);
      await packageBuild.create(
        name: p.basename(path_project),
        // isForce: args.arguments.contains("--force"),
      );
    } catch (e) {
      print(e);
    }
  }
  if (command == "read") {
    Directory directory_current = Directory.current;
    File file = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code = (yaml.loadYaml(file.readAsStringSync(), recover: true) as Map);

    print(json.encode(yaml_code));
    exit(0);
  }
  if (command == "build") {
    String type_platform = "";
    try {
      type_platform = args.arguments[1];
    } catch (e) {}
    PackagexPlatform packagex_platform = PackagexPlatform.current;
    List<PackagexPlatform> packagexPlatforms = PackagexPlatform.values;
    for (var i = 0; i < packagexPlatforms.length; i++) {
      PackagexPlatform packagexPlatform = packagexPlatforms[i];
      if (packagexPlatform.name != type_platform) {
        continue;
      }
      packagex_platform = packagexPlatform;
    }
    print("build for: ${packagex_platform.name}");
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
    String path_project = p.join(Directory.current.path);
    packagex_scheme.Packagex packagexConfig = packagex_scheme.Packagex({});

    // Map jsonData = {};
    for (var i = 0; i < args.arguments.length; i++) {
      String argument = args.arguments[i];
      if (!RegExp(r"^--", caseSensitive: false).hashData(argument)) {
        continue;
      }
      if (args[argument] != null && args[argument]!.isNotEmpty) {
        packagexConfig[argument.replaceAll(RegExp(r"^--"), "")] = args[argument];
      }
    }

    if (PackagexPlatform.all == packagex_platform) {
      for (var i = 0; i < packagexPlatforms.length; i++) {
        PackagexPlatform packagexPlatform = packagexPlatforms[i];
        if (packagexPlatform == PackagexPlatform.current) {
          continue;
        }
        await packageBuild.build(
          path_current: path_project,
          path_output: out,
          packagexPlatform: packagexPlatform,
          packagexConfig: packagexConfig,
        );
      }
    } else {
      await packageBuild.build(
        path_current: path_project,
        path_output: out,
        packagexPlatform: packagex_platform,
        packagexConfig: packagexConfig,
      );
    }
    return;
  }
  if (command == "install") {
    String package_name = args.arguments[1];

    if (RegExp(r"^http(s)?:\/\/.*$", caseSensitive: false).hashData(package_name)) {
      await packageX.installPackageFromUrl(
        url: package_name,
        onData: (data) {},
        onDone: () {},
      );
    } else {
      File file = File(package_name);
      if (file.existsSync()) {
        await packageX.installPackageFromFile(
          file: file,
          onData: (data) {},
          onDone: () {},
        );
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
  clean clean package
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
