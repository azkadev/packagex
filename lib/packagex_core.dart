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
// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, constant_identifier_names

import "dart:async";
import 'dart:convert';
import "package:github/github.dart";
import "package:http/http.dart";
import "package:mime/mime.dart";
import "package:packagex/extension/string.dart";
import "package:packagex/packagex_api_status.dart";
import "package:packagex/packagex_platform_type.dart";
import "package:packagex/scheme/scheme.dart";
import "package:universal_io/io.dart";

import 'package:general_lib/general_lib.dart';
// import 'package:path/path.dart' as p;
import 'package:path/path.dart' as path;
import "package:yaml/yaml.dart" as yaml;
import "package:yaml_writer/yaml_writer.dart";

import "package:collection/collection.dart";

/// Api
class Packagex {
  /// Api
  Packagex();

  Stream<PackagexApiStatus> create({
    required String newName,
    required Directory directoryPackage,
    required bool isApplication,
    required PackagexConfig? packagexConfig,
    bool isDontAddFlutterCommands = false,
  }) async* {
    packagexConfig ??= PackagexConfig({});
    Directory directory_project = await Future(() async {
      return Directory(Directory(path.join(directoryPackage.uri.toFilePath(), newName.trim())).uri.toFilePath());
    });
    String project_name = path.basename(directory_project.path);
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Started Create Project: ${project_name}");

    File file_pubspec = File(path.join(directory_project.path, "pubspec.yaml"));
    if (file_pubspec.existsSync() == false) {
      yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Started Create Project: ${(isApplication) ? "flutter" : "dart"} ${project_name}");
      List<String> arguments = () {
        List<String> defaults_args = [
          "create",
          newName,
          "--no-pub",
        ];
        if (isApplication) {
          defaults_args.addAll([
            "--offline",
          ]);
        } else {
          defaults_args.addAll([
            "--force",
          ]);
        }
        return defaults_args;
      }();
      Process process = await Process.start(
        (isApplication) ? "flutter" : "dart",
        arguments,
        workingDirectory: directory_project.parent.uri.toFilePath(),
      );
      process.stderr.listen((event) {
        stderr.add(event);
      });
      process.stdout.listen((event) {
        stdout.add(event);
      });
      int exit_code = await (process.exitCode);
      if (exit_code != 0) {
        yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed Create Project: ${(isApplication) ? "flutter" : "dart"} ${project_name}");
        return;
      } else {
        yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes Create Project: ${(isApplication) ? "flutter" : "dart"} ${project_name}");
      }
    }

    PackagexPubspec packagexPubspec = PackagexPubspec({});

    Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);
    packagexPubspec.rawData = yaml_code.clone();
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Started Check Pubspec Configuration: ${path.basename(file_pubspec.path)}");

    PackagexPubspec packagexPubspec_default = PackagexPubspec.create(
      dependencies: PackagexPubspecDependencies({
        "packagex": '^0.0.54',
      }),
      dev_dependencies: PackagexPubspecDevDependencies({
        "msix": '^3.16.7',
      }),
      packagex: PackagexConfig.create(
        name: project_name,
        dart_name: project_name,
        flutter_target: "main",
        dart_target: project_name,
        flutter_name: project_name,
        is_without_platform_name: true,
        is_app_auto_clean_up_folder: true,
        flutter_commands: (isDontAddFlutterCommands)
            ? PackagexConfigFlutterCommands.create()
            : PackagexConfigFlutterCommands.create(
                obfuscate: true,
                split_debug_info: "0.0.0",
                build_name: "0.0.0",
                build_number: 1,
                split_per_abi: true,
                no_tree_shake_icons: true,
              ),
        project_id: "azkadev.packagex",
        github_is_org: false,
        github_username: "azkadev",
      ),
      msix_config: PackagexMsixConfig.create(
        display_name: project_name,
        install_certificate: false,
      ),
    );
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Update Pubspec Configuration: ${path.basename(file_pubspec.path)}");

    packagexPubspec.rawData.general_lib_utils_updateMapIfNotSameOrEmptyOrNull(data: packagexPubspec_default.rawData, ignoreKeys: ["@type"]);
    packagexPubspec.rawData.general_lib_utils_removeRecursiveByKeys(keyDatas: ["@type"]);
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Remove Pubspec Keys: [\"@type\"] ${path.basename(file_pubspec.path)}");
    await file_pubspec.writeAsString(YamlWriter().write(packagexPubspec.toJson()));

    packagexPubspec.packagex.rawData.general_lib_utils_updateMapWithReplace(data: packagexConfig.rawData, ignoreKeys: ["@type"]);
    packagexPubspec.rawData.general_lib_utils_removeRecursiveByKeys(keyDatas: ["@type"]);
    if (isApplication) {
      if (!packagexPubspec.dev_dependencies.rawData.containsKey("msix")) {
        String message = "Add Package: Msix --dev";
        yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
        Process process = await Process.start(
          "flutter",
          ["pub", "add", "--dev", "msix"],
          workingDirectory: directory_project.parent.uri.toFilePath(),
        );
        process.stderr.listen((event) {
          stderr.add(event);
        });
        process.stdout.listen((event) {
          stdout.add(event);
        });
        int exit_code = await (process.exitCode);
        if (exit_code != 0) {
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
          return;
        } else {
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
        }
      }
    }
    // linux

    String scripts = """
Maintainer: "anonymous@noemail.com>"
Package: ${(packagexPubspec.name ?? project_name).packagex_utils_extension_toLinuxProgram()}
Version: ${packagexPubspec.version}
Section: x11
Priority: optional
Architecture: {{architecture_os}}
Essential: no
Installed-Size: 0
Description: "-"
Homepage: "-"
""";
    scripts = scripts.replaceAllMapped(RegExp(r"({{architecture_os}})", caseSensitive: false), (match) {
      if (Platform.isAndroid) {
        return "all";
      } else {
        return "all";
      }
    });
    // create folder
    //
    List<List<String>> packagex_linux_folders = [
      ["DEBIAN"],
      ["usr", "bin"],
      ["usr", "lib"],
      ["usr", "local"],
      ["usr", "local", "bin"],
      ["usr", "local", "lib"],
      ["usr", "share", "applications"],
      ["usr", "share", project_name.packagex_utils_extension_toLinuxProgram()],
    ];
    Directory directory_packagex_linux = Directory(path.join(directory_project.path, "linux", "packagex"));
    for (var i = 0; i < packagex_linux_folders.length; i++) {
      Directory directory_procces = Directory(path.join(directory_packagex_linux.path, path.joinAll(packagex_linux_folders[i])));
      if (directory_procces.existsSync() == false) {
        await directory_procces.create(recursive: true);
      }
    }

    File file_debian_control_packagex_linux = File(path.join(directory_packagex_linux.path, "DEBIAN", "control"));
    if (file_debian_control_packagex_linux.parent.existsSync() == false) {
      await file_debian_control_packagex_linux.parent.create(recursive: true);
    }
    if (file_debian_control_packagex_linux.existsSync() == false) {
      await file_debian_control_packagex_linux.writeAsString(scripts);
    }

    File file_debian_postinst_packagex_linux = File(path.join(directory_packagex_linux.path, "DEBIAN", "postinst"));
    if (file_debian_postinst_packagex_linux.parent.existsSync() == false) {
      await file_debian_postinst_packagex_linux.parent.create(recursive: true);
    }
    List<String> default_debian_postinsts_packagex_linux = [
      // "mkdir -p /usr/share/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "ln -s /usr/share/${project_name.packagex_utils_extension_toLinuxProgram()}/${project_name} /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}-app",
      "chmod +x /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}-app",
    ];
    if (file_debian_postinst_packagex_linux.existsSync() == false) {
      await file_debian_postinst_packagex_linux.writeAsString("""
#!/usr/bin/env sh
${default_debian_postinsts_packagex_linux.join("\n")}
exit 0
""");
    } else {
      String origin_data = await file_debian_postinst_packagex_linux.readAsString();
      List<String> origin_datas = origin_data.split("\n").map((e) => e.trim()).toList();
      origin_datas.removeWhere((element) => element.trim() == "exit 0");
      bool is_found_update = false;
      for (var i = 0; i < default_debian_postinsts_packagex_linux.length; i++) {
        String default_debian_postinst_packagex_linux = default_debian_postinsts_packagex_linux[i];
        if (!origin_datas.contains(default_debian_postinst_packagex_linux)) {
          is_found_update = true;
          origin_datas.add(default_debian_postinst_packagex_linux);
        }
      }
      if (origin_datas.contains("#!/usr/bin/env sh") == false) {
        origin_datas.insert(0, "#!/usr/bin/env sh");
      }
      if (origin_datas.contains("exit 0") == false) {
        origin_datas.add("exit 0");
      }

      await file_debian_postinst_packagex_linux.writeAsString(origin_datas.join("\n"));
    }

    File file_debian_postrm_packagex_linux = File(path.join(directory_packagex_linux.path, "DEBIAN", "postrm"));
    if (file_debian_postrm_packagex_linux.parent.existsSync() == false) {
      await file_debian_postrm_packagex_linux.parent.create(recursive: true);
    }
    List<String> default_debian_postrms_packagex_linux = [
      "rm -rf /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "rm -rf /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}-app",
      // "rm -rf /usr/share/${project_name.packagex_utils_extension_toLinuxProgram()}",
    ];
    if (file_debian_postrm_packagex_linux.existsSync() == false) {
      await file_debian_postrm_packagex_linux.writeAsString("""
#!/usr/bin/env sh
${default_debian_postrms_packagex_linux.join("\n")}
""");
    } else {
      default_debian_postrms_packagex_linux.removeAt(0);
      default_debian_postrms_packagex_linux.removeAt(0);
      String origin_data = await file_debian_postrm_packagex_linux.readAsString();
      List<String> origin_datas = origin_data.split("\n").map((e) => e.trim()).toList();
      bool is_found_update = false;
      for (var i = 0; i < default_debian_postrms_packagex_linux.length; i++) {
        String default_debian_postrm_packagex_linux = default_debian_postrms_packagex_linux[i];
        if (!origin_datas.contains(default_debian_postrm_packagex_linux)) {
          is_found_update = true;
          origin_datas.add(default_debian_postrm_packagex_linux);
        }
      }
      if (origin_datas.contains("#!/usr/bin/env sh") == false) {
        origin_datas.insert(0, "#!/usr/bin/env sh");
      }

      await file_debian_postrm_packagex_linux.writeAsString(origin_datas.join("\n"));
    }

    List<String> folder_bins = [
      path.join(directory_packagex_linux.path, "usr", "bin"),
      path.join(directory_packagex_linux.path, "usr", "local", "bin"),
    ];

    for (var i = 0; i < folder_bins.length; i++) {
      String folder_bin = folder_bins[i];

      File file_bin_packagex_linux_gitignore = File(path.join(folder_bin, ".gitignore"));
      if (file_bin_packagex_linux_gitignore.parent.existsSync() == false) {
        await file_bin_packagex_linux_gitignore.parent.create(recursive: true);
      }
      await file_bin_packagex_linux_gitignore.writeAsString("""* 
!.gitignore"""
          .trim());
    }

    File file_gitignore_packagex_linux = File(path.join(directory_packagex_linux.path, ".gitignore"));
    if (file_gitignore_packagex_linux.parent.existsSync() == false) {
      await file_gitignore_packagex_linux.parent.create(recursive: true);
    }

    List<String> default_gitignores_packagex_linux = [
      "usr/bin/${project_name}",
      "usr/share/${project_name}",
      "usr/local/bin/${project_name}",
      "usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "usr/share/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "usr/local/bin/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "usr/local/share/${project_name.packagex_utils_extension_toLinuxProgram()}",
    ];
    if (file_gitignore_packagex_linux.existsSync() == false) {
      await file_gitignore_packagex_linux.writeAsString(default_gitignores_packagex_linux.join("\n"));
    } else {
      String origin_data = await file_gitignore_packagex_linux.readAsString();
      List<String> origin_datas = origin_data.split("\n");
      bool is_found_update = false;
      for (var i = 0; i < default_gitignores_packagex_linux.length; i++) {
        String default_gitignore_packagex_linux = default_gitignores_packagex_linux[i];
        if (!origin_datas.contains(default_gitignore_packagex_linux)) {
          is_found_update = true;
          origin_datas.add(default_gitignore_packagex_linux);
        }
      }
      await file_gitignore_packagex_linux.writeAsString(origin_datas.join("\n"));
    }

    String app_desktop_linux = """
[Desktop Entry]
Type=Application
Version=${packagexPubspec.version}
Name=${project_name.split("_").map((e) => e.toUpperCaseFirstData()).join(" ")}
GenericName=General Application
Exec=${project_name.packagex_utils_extension_toLinuxProgram()}-app -- %u
Categories=Music;Media;
Keywords=Hello;World;Test;Application;
StartupNotify=true
""";
    File file_application_packagex_linux = File(path.join(directory_packagex_linux.path, "usr", "share", "applications", "${project_name}.desktop"));
    if (file_application_packagex_linux.parent.existsSync() == false) {
      await file_application_packagex_linux.parent.create(recursive: true);
    }

    if (file_application_packagex_linux.existsSync() == false) {
      await file_application_packagex_linux.writeAsString(app_desktop_linux);
    }
    if (Platform.isLinux) {
      String message = "Set Permission 775: ${file_debian_postinst_packagex_linux.path} ${file_debian_postrm_packagex_linux.path}";
      yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
      Process process = await Process.start(
        "chmod",
        [
          "775",
          file_debian_postinst_packagex_linux.path,
          file_debian_postrm_packagex_linux.path,
        ],
        runInShell: true,
        workingDirectory: directory_project.parent.uri.toFilePath(),
      );
      process.stderr.listen((event) {
        stderr.add(event);
      });
      process.stdout.listen((event) {
        stdout.add(event);
      });
      int exit_code = await (process.exitCode);
      if (exit_code != 0) {
        yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
        return;
      } else {
        yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
      }
    }
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Finished Create Project: ${project_name}");
  }

  Stream<PackagexApiStatus> build({
    required Directory directoryBase,
    required List<PackagexPlatformType> packagexPlatformTypes,
    required Directory? directoryBuild,
    required bool isApplication,
    required PackagexConfig? packagexConfig,
  }) async* {
    packagexConfig ??= PackagexConfig({});
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting Build: ${packagexPlatformTypes.map((e) => e.name.toUpperCaseFirstData()).join(", ")}");

    File file_pubspec = File(path.join(directoryBase.path, "pubspec.yaml"));
    var strm = create(
      newName: path.basename(directoryBase.path),
      directoryPackage: directoryBase.parent,
      isApplication: isApplication,
      packagexConfig: packagexConfig,
      isDontAddFlutterCommands: true,
    );
    await for (var event in strm) {
      yield event;
    }
    Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);

    PackagexPubspec packagexPubspec = PackagexPubspec(yaml_code.clone());

    packagexPubspec.packagex.rawData.general_lib_utils_updateMapWithReplace(data: packagexConfig.rawData, ignoreKeys: ["@type"]);
    packagexPubspec.rawData.general_lib_utils_removeRecursiveByKeys(keyDatas: ["@type"]);

    Directory directory_build_packagex = directoryBuild ?? Directory(path.join(directoryBase.path, "build", "packagex"));
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Directory Build: ${directory_build_packagex.uri.toFilePath()}");

    File file_script_pkgx = File(path.join(directoryBase.path, "lib", "packagex", "packagex.dart"));
    if (!file_script_pkgx.parent.existsSync()) {
      await file_script_pkgx.parent.create(
        recursive: true,
      );
    }
    Map json_data_package_detail = {
      "name": "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}".trim(),
      ...packagexPubspec.rawData,
      ...packagexPubspec.packagex.flutter_commands.rawData,
    };
    json_data_package_detail.removeByKeys([
      "environment",
      "dependencies",
      "dev_dependencies",
      "flutter",
      "packagex",
      "msix_config",
    ]);

    String packagex_script_project = """
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class PackagexProject${(packagexPubspec.packagex.flutter_name ?? packagexPubspec.name ?? "").split("_").map((e) => e.toUpperCaseFirstData()).join("").toUpperCaseFirstData()} {

  static bool isSame({
    required String data
  }) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }

    static String get default_data_to_string {
      return (JsonEncoder.withIndent(" " * 2).convert(default_data));
    }

    static Map get default_data {
return ${JsonEncoder.withIndent(" " * 2).convert(json_data_package_detail)};
    }

}
"""
        .trim();
    await file_script_pkgx.writeAsString(packagex_script_project);

    bool is_auto_delete = Platform.environment["packagex_is_auto_delete"] == "true";
    if (is_auto_delete) {
      if (directory_build_packagex.existsSync()) {
        await directory_build_packagex.delete(recursive: true);
      }
      await directory_build_packagex.create(recursive: true);
    } else {
      if (directory_build_packagex.existsSync() == false) {
        await directory_build_packagex.create(recursive: true);
      }
    }

    File file_packagex_release = File(path.join(directory_build_packagex.path, "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}.json"));
    await file_packagex_release.writeAsString(json_data_package_detail.toStringifyPretty(2));
    {
      Process process = await Process.start(
        (isApplication) ? "flutter" : "dart",
        [
          "pub",
          "get",
          "--offline",
        ],
        workingDirectory: directoryBase.path,
      );
      process.stderr.listen((event) {
        stderr.add(event);
      });
      process.stdout.listen((event) {
        stdout.add(event);
      });
      int exit_code = await (process.exitCode);
    }

    for (PackagexPlatformType packagex_platform_type in packagexPlatformTypes.toSet()) {
      PackagexPlatformType packagexPlatformType = packagex_platform_type;

      File script_cli = File(path.join(directoryBase.path, "bin", "${packagexPubspec.packagex.dart_target ?? packagexPubspec.name}.dart"));
      File script_app = File(path.join(directoryBase.path, "lib", "${packagexPubspec.packagex.flutter_target ?? "main"}.dart"));
      bool is_app = false;
      bool is_cli = false;
      if (script_app.existsSync()) {
        is_app = true;
      }
      if (script_cli.existsSync()) {
        is_cli = true;
      }

      List<String> flutter_commands = [];

      packagexPubspec.packagex.flutter_commands.rawData.forEach((key, value) {
        String key_args_flutter = "--${key.toString().replaceAll(RegExp(r"_"), "-")}";
        if (key_args_flutter == "--obfuscate") {
          if (value == true) {
            flutter_commands.add(key_args_flutter);
          }
        }
        if (key_args_flutter == "--split-per-abi") {
          if (value == true) {
            if (packagexPlatformType == PackagexPlatformType.android) {
              flutter_commands.add(key_args_flutter);
            }
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

      yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting Build: ${packagexPlatformType.name}");
      if (packagexPlatformType == PackagexPlatformType.android || packagexPlatformType == PackagexPlatformType.linux) {
        if (packagexPlatformType == PackagexPlatformType.linux) {
          if (!Platform.isLinux) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Package linux hanya bisa di perangkat linux saja !");
            continue;
          }

          Directory directory_linux_package = Directory(path.join(
            directoryBase.path,
            "linux",
            "packagex",
          ));

          Directory directory_packagex_app_user_share = Directory(path.join(
            directory_linux_package.path,
            "usr",
            "share",
            (packagexPubspec.name ?? "").replaceAll(RegExp(r"([_])"), "-"),
          ));

          if (is_app) {
            if (packagexPubspec.packagex.is_app_auto_clean_up_folder == true) {
              if (directory_packagex_app_user_share.existsSync()) {
                await directory_packagex_app_user_share.delete(recursive: true);
              }
              await directory_packagex_app_user_share.create(recursive: true);
            } else {
              if (directory_packagex_app_user_share.existsSync() == false) {
                await directory_packagex_app_user_share.create(recursive: true);
              }
            }
          }
          String message = "Set Permission: ${path.join(directory_linux_package.path, "DEBIAN")}";
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "chmod",
            [
              "-R",
              "775",
              path.join(directory_linux_package.path, "DEBIAN"),
            ],
            runInShell: true,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }

          File file_cli = File(path.join(
            directory_linux_package.path,
            "usr",
            "bin",
            "${packagexPubspec.packagex.dart_name ?? packagexPubspec.name!.replaceAll(RegExp(r"([_])"), "-")}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-cli-linux"}",
          ));
          File file_app = File(path.join(directory_build_packagex.path, "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-linux"}.deb"));

          if (is_cli) {
            String message = """
Compile Script Dart: 

From: ${script_cli.path}
To: ${file_cli.path}
"""
                .trim();
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "dart",
              [
                "compile",
                "exe",
                script_cli.path,
                "-o",
                file_cli.path,
              ],
              workingDirectory: directoryBase.path,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }
          if (is_cli) {
            String message = "Set Permission: ${file_cli.path}";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "chmod",
              [
                "775",
                file_cli.path,
              ],
              runInShell: true,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }

          if (is_app) {
            String message = " Flutter Build:";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "flutter",
              [
                "build",
                "linux",
                "--release",
                "--target=${script_app.path}",
                ...flutter_commands,
              ],
              workingDirectory: directoryBase.path,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }
          if (is_app) {
            String path_app = path.join(directoryBase.path, "build", "linux", "x64", "release", "bundle", ".");

            String message = "Copy App Files: From ${path_app} To ${directory_packagex_app_user_share.path} ";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "cp",
              [
                "-rf",
                path_app,
                directory_packagex_app_user_share.path,
              ],
              workingDirectory: directoryBase.path,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }

          if (is_app || is_cli) {
            String message = "Set Permission: chmod -R 755 ${directory_linux_package.path}";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "chmod",
              ["-R", "775", directory_linux_package.path],
              runInShell: true,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }
          if (is_app || is_cli) {
            String message = "Dpkg Build: ${file_app.path}";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "dpkg-deb",
              [
                "--build",
                "--root-owner-group",
                directory_linux_package.path,
                file_app.path,
              ],
              workingDirectory: directoryBase.path,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
            try {
              if (file_cli.existsSync()) {
                await file_cli.delete(recursive: true);
              }
            } catch (e) {}
          }

          if (packagexPubspec.packagex.is_app_auto_clean_up_folder == true) {
            await directory_packagex_app_user_share.delete(recursive: true);
          }

          continue;
        }

        if (packagexPlatformType == PackagexPlatformType.android) {
          if (is_app) {
            String message = " Flutter Build:";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "flutter",
              [
                "build",
                "apk",
                "--release",
                "--split-per-abi",
                "--target=${script_app.path}",
                ...flutter_commands,
              ],
              workingDirectory: directoryBase.path,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
            Directory directory_apk = Directory(path.join(directoryBase.path, "build", "app", "outputs", "flutter-apk"));
            List<FileSystemEntity> dirs = directory_apk.listSync();
            for (var i = 0; i < dirs.length; i++) {
              FileSystemEntity dir = dirs[i];
              try {
                if (dir is Directory) {
                } else if (dir is File) {
                  if (path.extension(dir.path) != ".apk") {
                    continue;
                  }
                  if (path.basename(dir.path) == "app-release.apk") {
                    continue;
                  }
                  await dir.absolute.copy(path.join(directory_build_packagex.path, path.basename(dir.path).replaceAll(RegExp("^(app)", caseSensitive: false), "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}")));
                  await dir.absolute.delete(
                    recursive: true,
                  );
                }
              } catch (e) {}
            }
          }
        }
      }
      if (packagexPlatformType == PackagexPlatformType.windows) {
        if (!Platform.isWindows) {
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Package windows hanya bisa di perangkat windows saja !");
          continue;
        }
        File file_cli = File(
          path.join(directory_build_packagex.path, "${packagexPubspec.packagex.dart_name ?? packagexPubspec.name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-cli-windows"}.exe"),
        );
        if (is_cli) {
          String message = """
Compile Script Dart: 

From: ${script_cli.path}
To: ${file_cli.path}
"""
              .trim();
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "dart",
            [
              "compile",
              "exe",
              script_cli.path,
              "-o",
              file_cli.path,
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
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
          packagexPubspec.msix_config.rawData.forEach((key, value) {
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
          String message = " Flutter Build: ";
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "flutter",
            [
              "pub",
              "run",
              "msix:create",
              "--windows-build-args",
              "--target=${script_app.path} ${flutter_commands.join(" ")}",
              "-o",
              directory_build_packagex.path,
              "-n",
              "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-app-windows"}",
              ...args_msix,
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
        }
      }

      if (packagexPlatformType == PackagexPlatformType.macos) {
        if (!Platform.isMacOS) {
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Package macos hanya bisa di perangkat macos saja !");
          // return {"@type": "error", "message": "platform_not_supported", "description": "Package macos hanya bisa di perangkat macos saja !"};
          continue;
        }
        File file_cli = File(path.join(directory_build_packagex.path, "${packagexPubspec.packagex.dart_name ?? packagexPubspec.name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-cli-macos"}"));
        if (is_cli) {
          String message = """
Compile Script Dart: 

From: ${script_cli.path}
To: ${file_cli.path}
"""
              .trim();
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "dart",
            [
              "compile",
              "exe",
              script_cli.path,
              "-o",
              file_cli.path,
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
        }

        if (is_app) {
          String message = " Flutter Build: ";
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "flutter",
            [
              "build",
              "macos",
              "--release",
              "--target=${script_app.path}",
              ...flutter_commands,
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
        }
      }

      if (packagexPlatformType == PackagexPlatformType.ios) {
        if (!Platform.isMacOS) {
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Package ios hanya bisa di perangkat macos saja !");
          continue;
        }

        if (is_app) {
          String message = " Flutter Build:";
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "flutter",
            [
              "build",
              "ios",
              "--release",
              "--no-codesign",
              "--target=${script_app.path}",
              ...flutter_commands,
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
        }
        if (is_app) {
          String message = " Flutter Build:";
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "sh",
            [
              "-c",
              """
cd build/ios/iphoneospackagexCli(args)
mkdir Payload
cd Payload
ln -s ../Runner.app
cd ..
zip -r  ${path.join(directory_build_packagex.path, "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-ios"}.ipa")} Payload
"""
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
        }
        continue;
      }

      if (packagexPlatformType == PackagexPlatformType.web) {
        if (is_app) {
          String message = " Flutter Build:";
          yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
          Process process = await Process.start(
            "flutter",
            [
              "build",
              "web",
              "--release",
              "--target=${script_app.path}",
              "--web-renderer",
              "html",
            ],
            workingDirectory: directoryBase.path,
          );
          process.stderr.listen((event) {
            stderr.add(event);
          });
          process.stdout.listen((event) {
            stdout.add(event);
          });
          int exit_code = await (process.exitCode);
          if (exit_code != 0) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
            return;
          } else {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
          }
        }
        if (is_app) {
          Directory directory_build_web_canvaskit = Directory(path.join(directoryBase.path, "build", "web", "canvaskit", "."));

          try {
            await directory_build_web_canvaskit.delete(recursive: true);
          } catch (e) {}

          if (Platform.isWindows) {
            String message = " Compress:";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "tar",
              [
                "-cf",
                path.join(directory_build_packagex.path, "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}-web.zip"),
                "*",
              ],
              workingDirectory: path.join(directoryBase.path, "build", "web"),
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }

          if (Platform.isMacOS || Platform.isLinux) {
            String message = " Compress:";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "zip",
              [
                "-r",
                path.join(directory_build_packagex.path, "${packagexPubspec.packagex.flutter_name ?? packagexPubspec.name}-web.zip"),
                ".",
              ],
              workingDirectory: path.join(directoryBase.path, "build", "web", "."),
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }
        }
        continue;
      }
    }
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Finished Build: ${packagexPlatformTypes.map((e) => e.name.toUpperCaseFirstData()).join(", ")}");
  }

  Future<int> installPackageFromUrl({
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
    Directory directory = Directory(path.join(Directory.current.path, "package_temp"));
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    File file = File(path.join(directory.path, path.basename(url)));
    if (file.existsSync()) {
      await file.delete();
    }
    await file.writeAsBytes(response.bodyBytes);
    return await installPackageFromFile(file: file, onData: onData, onDone: onDone);
    // .listen((event) {}).asFuture();
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
    required Directory directoryBase,
    String publishType = "stable",
    required FutureOr<dynamic> Function(String update) onUpdate,
  }) async {
    Directory directory_build = Directory(path.join(directoryBase.path, "build"));
    Directory directory_projectx = Directory(path.join(directory_build.path, "packagex"));

    String basename = path.basename(directoryBase.path);

    File file_pubspec = File(path.join(directoryBase.path, "pubspec.yaml"));
    Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);

    PackagexPubspec pubspec = PackagexPubspec(yaml_code.clone());
    if (pubspec["name"] == null) {
      pubspec["name"] = basename;
    }
    if (pubspec["packagex"] is Map == false) {
      pubspec["packagex"] = {};
    }
    String github_username = pubspec.packagex.github_username ?? "";
    GitHub gitHub = GitHub(auth: Authentication.withToken(tokenGithub));
    onUpdate("Check User");
    User user = await gitHub.users.getCurrentUser();
    onUpdate("Use Github: ${user.login}");
    RepositorySlug repositorySlug = RepositorySlug(github_username, pubspec.packagex.name ?? "");

    List<FileSystemEntity> files = await Future(() async {
      return directory_projectx.listSync().where((e) => [".deb", ".apk", ".msix", ".json"].contains(path.extension(e.path))).where((element) {
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
                pubspec.packagex.name,
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
            try {
              return await gitHub.repositories.createRelease(repositorySlug, CreateRelease(publishType), getIfExists: true);
            } catch (e) {
              if (e is GitHubError) {
                if (RegExp(r"Repository is empty", caseSensitive: false).hasMatch(e.message ?? "")) {
                  onUpdate("Create Repo: ${repositorySlug.fullName}");
                  await gitHub.repositories.deleteRepository(
                    repositorySlug,
                  );
                  rethrow;
                }
              }
              rethrow;
            }
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
        ReleaseAsset? releaseAsset = releaseAssets.firstWhereOrNull((element) => element.name == path.basename(fileSystemEntity.path));
        if (releaseAsset != null) {
          onUpdate("Delete Asset: ${releaseAsset.name}");
          await gitHub.repositories.deleteReleaseAsset(repositorySlug, releaseAsset);
        }
        onUpdate("Upload Asset: ${path.basename(fileSystemEntity.path)}");
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
              name: path.basename(fileSystemEntity.path),
              contentType: lookupMimeType(fileSystemEntity.path) ?? "",
              assetData: fileSystemEntity.readAsBytesSync(),
            ),
          },
        );

        onUpdate("Succes Upload Asset: ${path.basename(fileSystemEntity.path)}");
      }
    }
    onUpdate("Finished");
  }

  Future<int> installPackageFromFile({
    required File file,
    required FutureOr<void> Function(String data) onData,
    required FutureOr<void> Function() onDone,
    bool isPrint = true,
  }) async {
    Process process = await Process.start(
      "dpkg",
      [
        "--force-all",
        "-i",
        file.path,
      ],
    );
    process.stderr.listen((data) async {
      if (isPrint) {
        stdout.add(data);
      }
      await onData(utf8.decode(data, allowMalformed: true));
    });
    process.stdout.listen((data) async {
      if (isPrint) {
        stdout.add(data);
      }
      await onData(utf8.decode(data, allowMalformed: true));
    });
    int exit_code = await (process.exitCode);
    await onDone();
    return exit_code;
  }
}
