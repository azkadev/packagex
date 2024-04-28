/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps, empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:packagex/packagex.dart';

import 'package:general_lib/general_lib.dart';
import 'package:packagex/scheme/packagex_pubspec.dart';
import 'package:path/path.dart' as p;
import "package:yaml/yaml.dart" as yaml;
import "package:path/path.dart" as path;

Logger logger = Logger();

class PackagexEnvironment {
  PackagexEnvironment();

  static bool get is_not_interactive {
    return ((Platform.environment["packagex_is_no_interactive"] ?? "").trim() == "true");
  }

  static String get github_token {
    return (Platform.environment["packagex_github_token"] ?? "").trim();
  }
}

FutureOr<void> packagexCli(List<String> arguments_origins) async {
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
  File file_output = File(output_data ?? path.join(Directory.current.path, "output.json"));
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

    await packagex.create(newName: name ?? ".", directoryPackage: Directory.current, isApplication: false).listen((event) {
      printed(event);
    }).asFuture();
    exit(0);
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
    List<PackagexPlatformType> packagexPlatforms = [PackagexPlatformType.linux];
    await packagex.build(directoryBase: Directory.current, packagexPlatformTypes: packagexPlatforms).listen((event) {
      printed(event);
    }).asFuture();
    exit(0);
  }
  if (command == "install") {
    String package_name = args.arguments[1];

    if (RegExp(r"^http(s)?:\/\/.*$", caseSensitive: false).hashData(package_name)) {
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
      if (RegExp(r"^(ghp_)", caseSensitive: false).hasMatch(parse_token_github)) {
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
      String path_package_install_pub = args.after("activate") ?? Directory.current.path;
      if (path_package_install_pub == ".") {
        path_package_install_pub = Directory.current.path;
      }
      Directory directory_pub_hosted_pub_dev = Directory(path.join(Dart.pub.hosted_directory.path, "pub.dev"));
      File file_pubspec = File(path.join(path_package_install_pub, "pubspec.yaml"));
      if (!file_pubspec.existsSync()) {
        print("pubspec.yaml not Found");
        exit(0);
      }
      Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
      PackagexPubspec pubspec = PackagexPubspec(yaml_code);
      String pubspec_name = pubspec.name ?? "";
      String pubspec_version = pubspec.version ?? "";
      String new_name = "${pubspec_name}-${pubspec_version}";
      Directory directory_origin_pkg = Directory(path_package_install_pub);
      Process shell = await Process.start(
        "dart",
        ["pub", "global", "activate", "--source", "path", directory_origin_pkg.path, "--overwrite"],
      );

      shell.stderr.listen((event) {
        stderr.add(event);
      });
      shell.stdout.listen((event) {
        stdout.add(event);
      });
      int exitCode = await shell.exitCode;
      exit(exitCode);
    }

    if (args.after(command) == "install") {
      String path_package_install_pub = args.after("install") ?? Directory.current.path;
      if (path_package_install_pub == ".") {
        path_package_install_pub = Directory.current.path;
      }
      Directory directory_pub_hosted_pub_dev = Directory(path.join(Dart.pub.hosted_directory.path, "pub.dev"));
      File file_pubspec = File(path.join(path_package_install_pub, "pubspec.yaml"));
      if (!file_pubspec.existsSync()) {
        print("pubspec.yaml not Found");
        exit(0);
      }
      Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
      PackagexPubspec pubspec = PackagexPubspec(yaml_code);
      String pubspec_name = pubspec.name ?? "";
      String pubspec_version = pubspec.version ?? "";
      String new_name = "${pubspec_name}-${pubspec_version}";

      Directory directory_new_pub_hosted_pubdev = Directory(path.join(directory_pub_hosted_pub_dev.path, new_name));
      if (directory_new_pub_hosted_pubdev.existsSync()) {
        bool is_force = args.contains(["-f", "--force"]);
        if (is_force) {
          print("Force Install Package");
          print("Delete Old");
          await directory_new_pub_hosted_pubdev.delete(recursive: true);
          print("Create New");
          await directory_new_pub_hosted_pubdev.create(recursive: true);
        } else {
          print("${pubspec_name} Version: ${pubspec_version} Found in use --force");
          exit(0);
        }
      } else {
        await directory_new_pub_hosted_pubdev.create(recursive: true);
      }
      print("Installing Package ${pubspec_name} Version: ${pubspec_version} ");
      Directory directory_origin_pkg = Directory(path_package_install_pub);

      directory_origin_pkg.copyTo(directory_new_pub_hosted_pubdev, ignoreDirList: [
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

Map<String, Progress> progress_data = {};
void printed(PackagexApiStatus event) {
  if (event.packagexApiStatusType == PackagexApiStatusType.progress_start) {
    progress_data[event.status_id] = logger.progress(event.value);
    return;
  }
  if (event.packagexApiStatusType == PackagexApiStatusType.progress) {
    Progress? progress = progress_data[event.status_id];
    if (progress == null) {
      progress = logger.progress(event.value);
      progress_data[event.status_id] = progress;
    }
    progress.update(event.value);
    return;
  }
  if (event.packagexApiStatusType == PackagexApiStatusType.progress_complete) {
    Progress? progress = progress_data[event.status_id];
    if (progress == null) {
      progress = logger.progress(event.value);
      progress_data[event.status_id] = progress;
    }
    progress.update(event.value);
    progress.complete(event.value);

    // progress.cancel();
    return;
  }
  if (event.packagexApiStatusType == PackagexApiStatusType.succes) {
    logger.success(event.value);
    return;
  }
  if (event.packagexApiStatusType == PackagexApiStatusType.failed) {
    logger.err(event.value);
    return;
  }

  logger.info(event.value);
}
