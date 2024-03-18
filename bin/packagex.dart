// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:packagex/packagex.dart';

import 'package:general_lib/general_lib.dart';
import 'package:packagex/scheme/pubspec.dart';
import 'package:path/path.dart' as p;
import "package:yaml/yaml.dart" as yaml;
import "package:packagex/scheme/scheme.dart" as packagex_scheme;
import "package:path/path.dart" as path;

import "package:packagex/shell/shell.dart" as packagex_shell;

Logger logger = Logger();

class PackagexEnvironment {
  PackagexEnvironment();

  static bool get is_not_interactive {
    return ((Platform.environment["packagex_is_no_interactive"] ?? "").trim() ==
        "true");
  }

  static String get github_token {
    return (Platform.environment["packagex_github_token"] ?? "").trim();
  }
}

void main(List<String> arguments_origins) async {
  Args args = Args(arguments_origins);
  Packagex packagex = Packagex();

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
    "pub",
  ];

  commands.sort();
  if (args.arguments.isEmpty) {
    while (true) {
      if (PackagexEnvironment.is_not_interactive) {
        print(menu_help);
        exit(0);
      }
      await Future.delayed(Duration(microseconds: 1));

      String choose_data = logger.chooseOne<String>(
        "Select",
        choices: commands,
        defaultValue: commands.firstOrNull,
      );
      if (commands.contains(choose_data)) {
        args.arguments.add(choose_data);
        break;
      }
    }
  }

  bool args_is_to_json = args.contains([
    "--toJson",
    "--tojson",
    "-toJson",
    "-tojson",
  ]);
  bool args_is_force = args.contains(["-f", "--force"]);
  bool args_is_verbose = args.contains(["-v", "--verbose"]);
  bool args_is_help = args.contains(["-h", "--help"]);
  String? output_data = args["-o"];
  File file_output =
      File(output_data ?? path.join(Directory.current.path, "output.json"));
  String command = args[0] ?? "";

  String sub_command = args.after(command) ?? "";
  if (command == "help") {
    try {
      args.arguments.removeAt(0);
    } catch (e) {
      print(e);
    }
    if (args_is_help) {
    } else {
      args_is_help = true;
      args.arguments.add("-h");
    }
    command = args[0] ?? "help";
  }
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
    await packagex.clean();
    print("Complete Clean");
    return;
  }
  if (command == "create") {
    String? name = await Future(() async {
      try {
        return args.arguments[1];
      } catch (e) {
        while (true) {
          if (PackagexEnvironment.is_not_interactive) {
            print(menu_help);
            exit(0);
          }
          await Future.delayed(Duration(microseconds: 1));

          String result = logger.prompt("Name Project:").trim();

          if (result.isNotEmpty) {
            return result;
          }
        }
      }
    });
    String path_project = p.join(Directory.current.path, name);

    await packagex.create(
      name: p.basename(path_project),
      // isForce: args.arguments.contains("--force"),
    );
  }
  if (command == "read") {
    Directory directory_current = Directory.current;
    File file = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code =
        (yaml.loadYaml(file.readAsStringSync(), recover: true) as Map);

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
        packagexConfig[argument.replaceAll(RegExp(r"^--"), "")] =
            args[argument];
      }
    }

    if (PackagexPlatform.all == packagex_platform) {
      for (var i = 0; i < packagexPlatforms.length; i++) {
        PackagexPlatform packagexPlatform = packagexPlatforms[i];
        if (packagexPlatform == PackagexPlatform.current) {
          continue;
        }
        await packagex.build(
          path_current: path_project,
          path_output: out,
          packagexPlatform: packagexPlatform,
          packagexConfig: packagexConfig,
        );
      }
    } else {
      await packagex.build(
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

    if (RegExp(r"^http(s)?:\/\/.*$", caseSensitive: false)
        .hashData(package_name)) {
      await packagex.installPackageFromUrl(
        url: package_name,
        onData: (data) {},
        onDone: () {},
      );
    } else {
      File file = File(package_name);
      if (file.existsSync()) {
        await packagex.installPackageFromFile(
          file: file,
          onData: (data) {},
          onDone: () {},
        );
      } else {
        // Platform.pathSeparator;

        await packagex.installPackage(
          name_package: package_name,
        );
      }
    }
  }

  if (command == "publish") {
    String tokenGithub = await Future(() async {
      String parse_token_github = PackagexEnvironment.github_token;
      if (RegExp(r"^(ghp_)", caseSensitive: false)
          .hasMatch(parse_token_github)) {
        return parse_token_github;
      }
      while (true) {
        if (PackagexEnvironment.is_not_interactive) {
          print(menu_help);
          exit(0);
        }
        await Future.delayed(Duration(microseconds: 1));

        String result = logger.prompt("token Github (ghp_):").trim();

        if (RegExp(r"^(ghp_)", caseSensitive: false).hasMatch(result)) {
          return result;
        }
      }
    });
    Progress progress = logger.progress("Start Publish");
    await packagex.publish(
      tokenGithub: tokenGithub,
      onUpdate: (update) {
        progress.update(update);
      },
    );
    progress.complete("Finished Publish");
  }

  if (command == "pub") {
    if (args.after(command) == "activate") {
      String path_package_install_pub =
          args.after("activate") ?? Directory.current.path;
      if (path_package_install_pub == ".") {
        path_package_install_pub = Directory.current.path;
      }
      Directory directory_pub_hosted_pub_dev =
          Directory(path.join(dart.pub.hosted_directory.path, "pub.dev"));
      File file_pubspec =
          File(path.join(path_package_install_pub, "pubspec.yaml"));
      if (!file_pubspec.existsSync()) {
        print("pubspec.yaml not Found");
        exit(0);
      }
      Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(),
          recover: true) as Map);
      Pubspec pubspec = Pubspec(yaml_code);
      String pubspec_name = pubspec.name ?? "";
      String pubspec_version = pubspec.version ?? "";
      String new_name = "${pubspec_name}-${pubspec_version}";
      Directory directory_origin_pkg = Directory(path_package_install_pub);
      await packagex_shell.shell(
        executable: "dart",
        arguments: [
          "pub",
          "global",
          "activate",
          "--source",
          "path",
          directory_origin_pkg.path,
          "--overwrite"
        ],
        onStdout: (data, executable, arguments, workingDirectory, environment,
            includeParentEnvironment, runInShell, mode) {
          stdout.add(data);
        },
        onStderr: (data, executable, arguments, workingDirectory, environment,
            includeParentEnvironment, runInShell, mode) {
          stderr.add(data);
        },
      );

      print("complete");
      exit(0);
    }

    if (args.after(command) == "install") {
      String path_package_install_pub =
          args.after("install") ?? Directory.current.path;
      if (path_package_install_pub == ".") {
        path_package_install_pub = Directory.current.path;
      }
      Directory directory_pub_hosted_pub_dev =
          Directory(path.join(dart.pub.hosted_directory.path, "pub.dev"));
      File file_pubspec =
          File(path.join(path_package_install_pub, "pubspec.yaml"));
      if (!file_pubspec.existsSync()) {
        print("pubspec.yaml not Found");
        exit(0);
      }
      Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(),
          recover: true) as Map);
      Pubspec pubspec = Pubspec(yaml_code);
      String pubspec_name = pubspec.name ?? "";
      String pubspec_version = pubspec.version ?? "";
      String new_name = "${pubspec_name}-${pubspec_version}";

      Directory directory_new_pub_hosted_pubdev =
          Directory(path.join(directory_pub_hosted_pub_dev.path, new_name));
      if (directory_new_pub_hosted_pubdev.existsSync()) {
        bool is_force = args.contains(["-f", "--force"]);
        if (is_force) {
          print("Force Install Package");
          print("Delete Old");
          await directory_new_pub_hosted_pubdev.delete(recursive: true);
          print("Create New");
          await directory_new_pub_hosted_pubdev.create(recursive: true);
        } else {
          print(
              "${pubspec_name} Version: ${pubspec_version} Found in use --force");
          exit(0);
        }
      } else {
        await directory_new_pub_hosted_pubdev.create(recursive: true);
      }
      print("Installing Package ${pubspec_name} Version: ${pubspec_version} ");
      Directory directory_origin_pkg = Directory(path_package_install_pub);

      directory_origin_pkg
          .copyTo(directory_new_pub_hosted_pubdev, ignoreDirList: [
        ".dart_tool",
        "build",
        ".plugin_symlinks",
        "ephemeral",
        "example",
      ]);

      print("complete");
      exit(0);
    }
  }

  exit(0);
}

String menu_help = """
A command-line Package

Usage: packagex <command> [arguments]

Global options:
help                 Print this usage information

Available commands: 
  create Create New Package
  build Build package to platform
  clean clean package
  install (name/url/local_file) install package
  pub 

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
