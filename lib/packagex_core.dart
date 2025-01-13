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
import "package:packagex/extension/arguments.dart";
import "package:packagex/extension/string.dart";
import "package:packagex/packagex_api_status.dart";
import "package:packagex/packagex_platform_type.dart";
import "package:packagex/scheme/scheme.dart";
import "package:io_universe/io_universe.dart";

import 'package:general_lib/general_lib.dart';
// import 'package:path/path.dart' as p;
import 'package:path/path.dart' as path;
import "package:telegram_client/telegram_client.dart";
import "package:yaml/yaml.dart" as yaml;
import "package:yaml_writer/yaml_writer.dart";

import "package:collection/collection.dart";
import "package:supabase_client/supabase_client.dart" as supabase_client;

/// Api
class Packagex {
  /// Api
  Packagex();
  /// UncompleteDocumentation
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

    final PackagexPubspec packagexPubspec_default = PackagexPubspec.create(
      dev_dependencies: PackagexPubspecDevDependencies({
        "msix": '^3.16.8',
      }),
      packagex: PackagexConfig.create(
        name: project_name,
        is_without_platform_name: true,
        is_app_auto_clean_up_folder: true,
        flutter_build_arguments: [
          if (isDontAddFlutterCommands == false) ...[
            "--split-per-abi",
            "--build-name",
            "0.0.0",
            "--build-number",
            "0.0.0",
            "--obfuscate",
            "--split-debug-info",
            "packagex-build-debug",
          ],
        ],
        dart_compile_exe_arguments: [
          if (isDontAddFlutterCommands == false) ...[
            "--save-debugging-info=packagex-compile-debug",
          ],
        ],
        packages: [
          PackagexConfigPackage.create(
            dart_name: project_name,
            dart_target: project_name,
            flutter_name: project_name,
            flutter_target: "main",
            output_name: project_name.packagex_utils_extension_toLinuxProgram(),
          ),
        ],
        uploads: [
          PackagexConfigUpload.create(
            platform_type: "github",
            github_repository_name: project_name,
            github_username: "archivon-apps-stores",
            github_tag: "release",
            github_is_org: false,
          ),
          PackagexConfigUpload.create(
            platform_type: "supabase",
            supabase_folder_name: "release",
          ),
          PackagexConfigUpload.create(
            platform_type: "telegram",
            telegram_chats: [
              PackagexConfigUploadTelegramChat.create(
                chat_id: "@slebew",
                message_thread_id: "",
              ),
            ],
          ),
        ],
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
      ["opt", project_name.packagex_utils_extension_toLinuxProgram()],
      ["usr", "bin"],
      ["usr", "lib"],
      ["usr", "local"],
      ["usr", "local", "bin"],
      ["usr", "local", "lib"],
      ["usr", "share", "applications"],
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
      // chmod dahulu
      // "chmod +x /opt/${project_name.packagex_utils_extension_toLinuxProgram()}/${project_name}",
      // link dahulu agar bisa jalaanin via cli
      "ln --force -s /opt/${project_name.packagex_utils_extension_toLinuxProgram()}/${project_name} /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}-app",

      /// chmod agar bisa run
      "chmod +x /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}-app"
    ];
    // default_debian_postinsts_packagex_linux.clear();
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
      // "rm -rf /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}-app",
      // "rm -rf /usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}",
      // "rm -rf /opt/${project_name.packagex_utils_extension_toLinuxProgram()}/",
      // "rm -rf /usr/share/applications/${project_name}.desktop",
    ];
    // default_debian_postrms_packagex_linux.clear();
    if (file_debian_postrm_packagex_linux.existsSync() == false) {
      await file_debian_postrm_packagex_linux.writeAsString("""
#!/usr/bin/env sh
${default_debian_postrms_packagex_linux.join("\n")}
""");
    } else {
      // default_debian_postrms_packagex_linux.removeAt(0);
      // default_debian_postrms_packagex_linux.removeAt(0);
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
      "opt/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "usr/bin/${project_name}",
      "usr/share/${project_name}",
      "usr/local/bin/${project_name}",
      "usr/bin/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "usr/share/${project_name.packagex_utils_extension_toLinuxProgram()}",
      "usr/local/bin/${project_name.packagex_utils_extension_toLinuxProgram()}",
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
Name=${project_name.split("_").map((e) => e.toUpperCaseFirstData()).join(" ")}
GenericName=${project_name.split("_").map((e) => e.toUpperCaseFirstData()).join(" ")}
Version=${packagexPubspec.version}
Exec=/opt/${project_name.packagex_utils_extension_toLinuxProgram()}/${project_name}
Icon=/opt/${project_name.packagex_utils_extension_toLinuxProgram()}/data/flutter_assets/assets/icon.png
Terminal=false
Type=Application
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
  /// UncompleteDocumentation
  Stream<PackagexApiStatus> build({
    required Directory directoryBase,
    required List<PackagexPlatformType> packagexPlatformTypes,
    required Directory? directoryBuild,
    required bool isApplication,
    required PackagexConfig? packagexConfig,
  }) async* {
    packagexConfig ??= PackagexConfig({});
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting Build: ${packagexPlatformTypes.map((e) => e.name.toUpperCaseFirstData()).join(", ")}");

    final File file_pubspec = File(path.join(directoryBase.path, "pubspec.yaml"));

    await for (final streamCreate in create(
      newName: path.basename(directoryBase.path),
      directoryPackage: directoryBase.parent,
      isApplication: isApplication,
      packagexConfig: packagexConfig,
      isDontAddFlutterCommands: true,
    )) {
      yield streamCreate;
    }
    final Map yaml_code = (yaml.loadYaml(file_pubspec.readAsStringSync(), recover: true) as Map);

    final PackagexPubspec packagexPubspec = PackagexPubspec(yaml_code.clone());

    packagexPubspec.packagex.rawData.general_lib_utils_updateMapWithReplace(data: packagexConfig.rawData, ignoreKeys: ["@type"]);
    packagexPubspec.rawData.general_lib_utils_removeRecursiveByKeys(keyDatas: ["@type"]);

    final Directory directory_build_packagex = directoryBuild ?? Directory(path.join(directoryBase.path, "build", "packagex"));
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Directory Build: ${directory_build_packagex.uri.toFilePath()}");

    final File file_script_pkgx = File(path.join(directoryBase.path, "lib", "packagex", "packagex.dart"));
    if (file_script_pkgx.parent.existsSync() == false) {
      await file_script_pkgx.parent.create(
        recursive: true,
      );
    }
    final Map json_data_package_detail = {
      "name": "${packagexPubspec.name}".trim(),
      ...packagexPubspec.rawData,
    };

    json_data_package_detail.removeByKeys([
      "environment",
      "dependencies",
      "dev_dependencies",
      "dependency_overrides",
      "flutter",
      "packagex",
      "msix_config",
    ]);

    final String packagex_script_project = """
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

/// AutoGenerateBy Packagex
class PackagexProject${(packagexPubspec.name ?? "").split("_").map((e) => e.toUpperCaseFirstData()).join("").toUpperCaseFirstData()} {
/// AutoGenerateBy Packagex
  static bool isSame({
    required String data
  }) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }
/// AutoGenerateBy Packagex
    static String get default_data_to_string {
      return (JsonEncoder.withIndent(" " * 2).convert(default_data));
    }
/// AutoGenerateBy Packagex
    static Map get default_data {
return ${JsonEncoder.withIndent(" " * 2).convert(json_data_package_detail)};
    }

}
"""
        .trim();
    await file_script_pkgx.writeAsString(packagex_script_project);

    final bool is_auto_delete = Platform.environment["packagex_is_auto_delete"] == "true";
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

    {
      final Process process = await Process.start(
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
      final int exit_code = await (process.exitCode);
    }

    final List<PackagexConfigPackage> packages = packagexPubspec.packagex.packages;
    for (final PackagexConfigPackage packagexConfigPackage in packages) {
      final String dart_target = packagexConfigPackage.dart_target ?? packagexPubspec.name ?? "";
      final String dart_name = packagexConfigPackage.dart_name ?? packagexPubspec.name!.packagex_utils_extension_toLinuxProgram();
      final String flutter_target = packagexConfigPackage.flutter_target ?? "main";
      final String flutter_name = packagexConfigPackage.flutter_name ?? packagexPubspec.name ?? "";
      final String output_name = packagexConfigPackage.output_name ?? (packagexPubspec.name ?? "").packagex_utils_extension_toLinuxProgram();

      final File file_packagex_release = File(path.join(directory_build_packagex.path, "${output_name}.json"));
      await file_packagex_release.writeAsString(json_data_package_detail.toStringifyPretty(2));

      for (final PackagexPlatformType packagexPlatformType in packagexPlatformTypes.toSet()) {
        final File script_cli = File(path.join(directoryBase.path, "bin", "${dart_target}.dart"));
        final File script_app = File(path.join(directoryBase.path, "lib", "${flutter_target}.dart"));
        final bool is_app = script_app.existsSync();
        final bool is_cli = script_cli.existsSync();

        final List<String> dart_compile_arguments = packagexPubspec.packagex.dart_compile_exe_arguments.clone();
        final List<String> flutter_build_arguments = packagexPubspec.packagex.flutter_build_arguments.clone();

        yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting Build: ${packagexPlatformType.name}");
        if (packagexPlatformType == PackagexPlatformType.android || packagexPlatformType == PackagexPlatformType.linux) {
          if (packagexPlatformType == PackagexPlatformType.linux) {
            if (!Platform.isLinux) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Package linux hanya bisa di perangkat linux saja !");
              continue;
            }

            final Directory directory_linux_package = Directory(path.join(
              directoryBase.path,
              "linux",
              "packagex",
            ));

            final Directory directory_linux_packagex_app_opt = Directory(path.join(
              directory_linux_package.path,
              "opt",
              (packagexPubspec.name ?? "").packagex_utils_extension_toLinuxProgram(),
            ));

            if (is_app) {
              if (packagexPubspec.packagex.is_app_auto_clean_up_folder == true) {
                if (directory_linux_packagex_app_opt.existsSync()) {
                  await directory_linux_packagex_app_opt.delete(recursive: true);
                }
                await directory_linux_packagex_app_opt.create(recursive: true);
              } else {
                if (directory_linux_packagex_app_opt.existsSync() == false) {
                  await directory_linux_packagex_app_opt.create(recursive: true);
                }
              }
            }
            final String message = "Set Permission: ${path.join(directory_linux_package.path, "DEBIAN")}";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            final Process process = await Process.start(
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
            final int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }

            final File file_cli = File(path.join(
              directory_linux_package.path,
              "usr",
              "bin",
              "${dart_name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-cli-linux"}",
            ));
            final File file_output_app = File(path.join(directory_build_packagex.path, "${output_name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-linux"}.deb"));

            if (is_cli) {
              final String message = """
Compile Script Dart: 

From: ${script_cli.path}
To: ${file_cli.path}
"""
                  .trim();
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              final Process process = await Process.start(
                "dart",
                [
                  "compile",
                  "exe",
                  ...dart_compile_arguments,
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
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
            }
            if (is_cli) {
              final String message = "Set Permission: ${file_cli.path}";
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              final Process process = await Process.start(
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
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
            }

            if (is_app) {
              final String message = " Flutter Build:";
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              final Process process = await Process.start(
                "flutter",
                [
                  "build",
                  "linux",
                  "--release",
                  "--target=${script_app.path}",
                  ...flutter_build_arguments.packagexUtilsParseFlutterArgumentsLinux(),
                ],
                workingDirectory: directoryBase.path,
              );
              process.stderr.listen((event) {
                stderr.add(event);
              });
              process.stdout.listen((event) {
                stdout.add(event);
              });
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
            }
            if (is_app) {
              final String path_app = path.join(directoryBase.path, "build", "linux", "x64", "release", "bundle", ".");

              final String message = "Copy App Files: From ${path_app} To ${directory_linux_packagex_app_opt.path} ";
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              final Process process = await Process.start(
                "cp",
                [
                  "-rf",
                  path_app,
                  directory_linux_packagex_app_opt.path,
                ],
                workingDirectory: directoryBase.path,
              );
              process.stderr.listen((event) {
                stderr.add(event);
              });
              process.stdout.listen((event) {
                stdout.add(event);
              });
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
            }

            if (is_app || is_cli) {
              final String message = "Set Permission: chmod -R 755 ${directory_linux_package.path}";
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
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
            }
            if (is_app || is_cli) {
              final String message = "Dpkg Build: ${file_output_app.path}";
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              final Process process = await Process.start(
                "dpkg-deb",
                [
                  "--build",
                  "--root-owner-group",
                  directory_linux_package.path,
                  file_output_app.path,
                ],
                workingDirectory: directoryBase.path,
              );
              process.stderr.listen((event) {
                stderr.add(event);
              });
              process.stdout.listen((event) {
                stdout.add(event);
              });
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(
                  packagexApiStatusType: PackagexApiStatusType.failed,
                  value: "Failed ${message}",
                );
              } else {
                yield PackagexApiStatus(
                  packagexApiStatusType: PackagexApiStatusType.succes,
                  value: "Succes ${message}",
                );
              }
              try {
                if (file_cli.existsSync()) {
                  await file_cli.delete(recursive: true);
                }
              } catch (e) {}
            }

            if (packagexPubspec.packagex.is_app_auto_clean_up_folder == true) {
              if (directory_linux_packagex_app_opt.existsSync()) {
                await directory_linux_packagex_app_opt.delete(recursive: true);
              }
            }

            continue;
          }

          if (packagexPlatformType == PackagexPlatformType.android) {
            if (is_app) {
              final String message = " Flutter Build:";
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              final Process process = await Process.start(
                "flutter",
                [
                  "build",
                  "apk",
                  "--release",
                  "--split-per-abi",
                  "--target=${script_app.path}",
                  ...flutter_build_arguments.packagexUtilsParseFlutterArgumentsAndroid(),
                ],
                workingDirectory: directoryBase.path,
              );
              process.stderr.listen((event) {
                stderr.add(event);
              });
              process.stdout.listen((event) {
                stdout.add(event);
              });
              final int exit_code = await (process.exitCode);
              if (exit_code != 0) {
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
              final Directory directory_apk = Directory(path.join(directoryBase.path, "build", "app", "outputs", "flutter-apk"));
              final List<FileSystemEntity> dirs = directory_apk.listSync();
              for (var i = 0; i < dirs.length; i++) {
                final FileSystemEntity dir = dirs[i];
                try {
                  if (dir is Directory) {
                  } else if (dir is File) {
                    if (path.extension(dir.path) != ".apk") {
                      continue;
                    }
                    if (path.basename(dir.path) == "app-release.apk") {
                      continue;
                    }
                    await dir.absolute.copy(path.join(directory_build_packagex.path, path.basename(dir.path).replaceAll(RegExp("^(app)", caseSensitive: false), "${output_name}")));
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
          final File file_cli = File(
            path.join(directory_build_packagex.path, "${dart_name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-cli-windows"}.exe"),
          );
          if (is_cli) {
            final String message = """
Compile Script Dart: 

From: ${script_cli.path}
To: ${file_cli.path}
"""
                .trim();
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            final Process process = await Process.start(
              "dart",
              [
                "compile",
                "exe",
                ...dart_compile_arguments,
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
            final int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }

          if (is_app) {
            final List<String> args_msix = [];
            final List<String> msix_args = [
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
            final String message = " Flutter Build: ";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            Process process = await Process.start(
              "flutter",
              [
                "pub",
                "run",
                "msix:create",
                "--windows-build-args",
                "--target=${script_app.path} ${flutter_build_arguments.packagexUtilsParseFlutterArgumentsWindows().join(" ")}",
                "-o",
                directory_build_packagex.path,
                "-n",
                "${flutter_name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-app-windows"}",
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
          if (Platform.isMacOS == false) {
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Package macos hanya bisa di perangkat macos saja !");
            // return {"@type": "error", "message": "platform_not_supported", "description": "Package macos hanya bisa di perangkat macos saja !"};
            continue;
          }
          final File file_cli = File(path.join(directory_build_packagex.path, "${dart_name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-cli-macos"}"));
          if (is_cli) {
            final String message = """
Compile Script Dart: 

From: ${script_cli.path}
To: ${file_cli.path}
"""
                .trim();
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            final Process process = await Process.start(
              "dart",
              [
                "compile",
                "exe",
                ...dart_compile_arguments,
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
            final int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }

          if (is_app) {
            final String message = " Flutter Build: ";
            yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
            final Process process = await Process.start(
              "flutter",
              [
                "build",
                "macos",
                "--release",
                "--target=${script_app.path}",
                ...flutter_build_arguments.packagexUtilsParseFlutterArgumentsMacos(),
              ],
              workingDirectory: directoryBase.path,
            );
            process.stderr.listen((event) {
              stderr.add(event);
            });
            process.stdout.listen((event) {
              stdout.add(event);
            });
            final int exit_code = await (process.exitCode);
            if (exit_code != 0) {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              return;
            } else {
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
            }
          }
        }

        if (packagexPlatformType == PackagexPlatformType.ios) {
          if (Platform.isMacOS == false) {
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
                ...flutter_build_arguments.packagexUtilsParseFlutterArgumentsIos(),
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
zip -r  ${path.join(directory_build_packagex.path, "${flutter_name}${(packagexPubspec.packagex.is_without_platform_name == true) ? "" : "-ios"}.ipa")} Payload
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
            if (Platform.isWindows) {
              String message = " Compress:";
              yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.info, value: "Starting ${message}");
              Process process = await Process.start(
                "tar",
                [
                  "-cf",
                  path.join(directory_build_packagex.path, "${flutter_name}-web.zip"),
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
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
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
                  path.join(directory_build_packagex.path, "${flutter_name}-web.zip"),
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
                /// THROW ERROR
                throw PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.failed, value: "Failed ${message}");
              } else {
                yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Succes ${message}");
              }
            }
          }
          continue;
        }
      }
    }
    yield PackagexApiStatus(packagexApiStatusType: PackagexApiStatusType.succes, value: "Finished Build: ${packagexPlatformTypes.map((e) => e.name.toUpperCaseFirstData()).join(", ")}");
  }
  /// UncompleteDocumentation
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
  /// UncompleteDocumentation
  Future<void> installPackage({
    required String name_package,
  }) async {
    String result_url_package = "";
  }  /// UncompleteDocumentation

  Future<void> searchPackage({
    required String name_package,
  }) async {
    String result_url_package = "";
  }
  /// UncompleteDocumentation
  Future<void> listPackageByPublisher({
    required String username,
  }) async {
    String result_url_package = "";
  }
  /// UncompleteDocumentation
  Stream<String> publish({
    required String tokenGithub,
    required String supabaseKey,
    required String supabaseUrl,
    required String telegramTokenBot,
    required Directory directoryBase,
  }) async* {
    Directory directory_build = Directory(path.join(directoryBase.path, "build"));
    Directory directory_build_temp = Directory(path.join(directory_build.path, "temp"));
    if (directory_build_temp.existsSync() == false) {
      directory_build_temp.createSync(recursive: true);
    }
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

    final List<FileSystemEntity> files = await Future(() async {
      return directory_projectx.listSync().where((e) => [".deb", ".apk", ".msix", ".json"].contains(path.extension(e.path))).where((element) {
        if (RegExp(pubspec.name ?? "", caseSensitive: false).hashData(element.path)) {
          return true;
        }
        return false;
      }).toList();
    });

    for (final PackagexConfigUpload packagexConfigUpload in pubspec.packagex.uploads) {
      await Future.delayed(Duration(seconds: 2));
      final String upload_platform_type = (packagexConfigUpload.platform_type ?? "").trim().toLowerCase();
      if (upload_platform_type == "telegram") {
        for (PackagexConfigUploadTelegramChat packagexConfigUploadTelegramChat in packagexConfigUpload.telegram_chats) {
          final dynamic telegram_chat_id = () {
            final num telegram_chat_id_number = num.tryParse(packagexConfigUploadTelegramChat.chat_id ?? "") ?? 0;
            if (telegram_chat_id_number != 0) {
              return telegram_chat_id_number;
            }
            return "@${(packagexConfigUploadTelegramChat.chat_id ?? "").replaceAll(RegExp("@"), "")}";
          }();
          final num telegram_thread_id = num.tryParse(packagexConfigUploadTelegramChat.message_thread_id ?? "0") ?? 0;
          yield "Upload To Telegram Chat Id: ${telegram_chat_id}";
          final TelegramClient telegramClient = TelegramClient();
          telegramClient.ensureInitialized(
            is_init_tdlib: false,
          );
          final TelegramClientData telegramClientData = TelegramClientData.telegramBotApi(token_bot: telegramTokenBot);
          for (final fileUpload in files) {
            if (fileUpload is File) {
              await Future.delayed(Duration(milliseconds: 500));
              final String fileName = path.basename(fileUpload.path);
              yield "Upload Telegram ${fileName}";
              await telegramClient.invoke(
                parameters: {
                  "@type": "sendDocument",
                  "chat_id": telegram_chat_id,
                  "message_thread_id": telegram_thread_id,
                  "document": TgUtils.telegram_bot_api_file(file: fileUpload),
                },
                is_form: true,
                telegramClientData: telegramClientData,
              );
              yield "Succes Telegram ${fileName}";
            }
          }
          yield "Upload To Telegram Chat Id: ${telegram_chat_id} Complete";
        }
      }
      if (upload_platform_type == "supabase") {
        final supabase_client.SupabaseClient supabaseClient = supabase_client.SupabaseClient(
          supabaseUrl,
          supabaseKey,
        );
        
        final String supabase_folder_name = (packagexConfigUpload.supabase_folder_name ?? "").trim();
        final supabase_client.SupabaseStorageClient storage = supabaseClient.storage;
        yield "Get Supabase Folder: ${supabase_folder_name}";
        try {
          await storage.getBucket(supabase_folder_name);
          yield "Exist Supabase Folder: ${supabase_folder_name}";
        } catch (e) {
          await storage.createBucket(supabase_folder_name, supabase_client.BucketOptions(public: true));
          yield "Create Supabase Folder: ${supabase_folder_name}";
        }
        final supabase_client.StorageFileApi storageFileApi = storage.from(supabase_folder_name);
        for (final fileUpload in files) {
          if (fileUpload is File) {
            yield "Delayed 2 Seconds";
            await Future.delayed(Duration(seconds: 2));
            final String fileName = path.basename(fileUpload.path);
            yield "Get Supabase File: ${fileName}";
            try {
              await storageFileApi.remove([fileName]);
              yield "Delete Supabase File: ${fileName}";
            } catch (e) {}
            yield "Delayed 2 Seconds";
            await Future.delayed(Duration(seconds: 2));
            while (true) {
            yield "Delayed 2 Seconds";
            await Future.delayed(Duration(seconds: 2));
              try {
                yield "Uploading Supabase File: ${fileName}";
                await storageFileApi.upload(
                  fileName,
                  fileUpload
                );
                yield "Succes Supabase File: ${fileName}";
                break;
              } catch (e) {
                yield "Try again Upload Supabase File: ${fileName}";
              }
            } 
          }
        }
        try {
          await supabaseClient.dispose();
        } catch (e) {}
        yield "Upload Supabase Complete: ${supabase_folder_name}";
      }
      if (upload_platform_type == "github") {
        final String github_username = packagexConfigUpload.github_username ?? "";
        final GitHub gitHub = GitHub(auth: Authentication.withToken(tokenGithub));
        yield "Check User";
        final User user = await gitHub.users.getCurrentUser();
        yield "Use Github: ${user.login}";
        final String githubReleaseTag = packagexConfigUpload.github_tag ?? "";
        final RepositorySlug repositorySlug = RepositorySlug(
          github_username,
          packagexConfigUpload.github_repository_name ?? pubspec.packagex.name ?? "",
        );

        yield "Upload List: ${files.length}";
        yield "Fetch Repo: ${repositorySlug.fullName}";
        final Repository repository = await Future(() async {
          try {
            return await gitHub.repositories.getRepository(
              repositorySlug,
            );
          } catch (e) {
            if (e is GitHubError) {
              if (RegExp(r"Repository not found", caseSensitive: false).hashData(e.message)) {
                // "Create Repo: ${repositorySlug.fullName}";
                return await gitHub.repositories.createRepository(
                  CreateRepository(
                    pubspec.packagex.name,
                    hasIssues: false,
                    autoInit: true,
                    gitignoreTemplate: "Dart",
                    licenseTemplate: "MIT",
                  ),
                  org: (packagexConfigUpload.github_is_org == true) ? github_username : null,
                );
              }
            }
            rethrow;
          }
        });

        yield "Fetch Release: ${repositorySlug.fullName} ${githubReleaseTag}";

        final Release release_repo = await Future(() async {
          try {
            return await gitHub.repositories.getReleaseByTagName(
              repositorySlug,
              githubReleaseTag,
            );
          } catch (e) {
            if (e is GitHubError) {
              if (RegExp(r"Release for tagName .* not found", caseSensitive: false).hasMatch(e.message ?? "")) {
                // yield "Create Release: ${repositorySlug.fullName} ${githubReleaseTag}";
                try {
                  return await gitHub.repositories.createRelease(repositorySlug, CreateRelease(githubReleaseTag), getIfExists: true);
                } catch (e) {
                  if (e is GitHubError) {
                    if (RegExp(r"Repository is empty", caseSensitive: false).hasMatch(e.message ?? "")) {
                      // yield "Create Repo: ${repositorySlug.fullName}";
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

        yield "Fetch Assets";
        final List<ReleaseAsset> releaseAssets = await gitHub.repositories.listReleaseAssets(repositorySlug, release_repo).toList();
        yield "Succes Fetch Assets: ${releaseAssets.length}";
        for (var i = 0; i < files.length; i++) {
          final FileSystemEntity fileSystemEntity = files[i];
          if (fileSystemEntity is File) {
            await Future.delayed(Duration(milliseconds: 500));
            final ReleaseAsset? releaseAsset = releaseAssets.firstWhereOrNull((element) => element.name == path.basename(fileSystemEntity.path));
            if (releaseAsset != null) {
              yield "Delete Asset: ${releaseAsset.name}";
              await gitHub.repositories.deleteReleaseAsset(repositorySlug, releaseAsset);
            }
            yield "Upload Asset: ${path.basename(fileSystemEntity.path)}";
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

            yield "Succes Upload Asset: ${path.basename(fileSystemEntity.path)}";
          }
        }
      }
    }
    yield "Finished";
    return;
  }
  /// UncompleteDocumentation
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
