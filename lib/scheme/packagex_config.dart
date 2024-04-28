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
// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_config_flutter_commands.dart";

class PackagexConfig extends JsonScheme {
  PackagexConfig(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexConfig",
      "name": "Pack",
      "dart_target": "",
      "flutter_target": "",
      "dart_name": "",
      "flutter_name": "",
      "is_without_platform_name": true,
      "flutter_commands": {
        "@type": "packagexConfigFlutterCommands",
        "obfuscate": true,
        "split-debug-info": "0.0.5",
        "build-name": "0.0.5",
        "build-number": 40,
        "split-per-abi": true,
        "no-tree-shake-icons": true
      },
      "project_id": "",
      "github_username": "",
      "github_is_org": true
    };
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  set special_type(String? value) {
    rawData["@type"] = value;
  }

  String? get name {
    try {
      if (rawData["name"] is String == false) {
        return null;
      }
      return rawData["name"] as String;
    } catch (e) {
      return null;
    }
  }

  set name(String? value) {
    rawData["name"] = value;
  }

  String? get dart_target {
    try {
      if (rawData["dart_target"] is String == false) {
        return null;
      }
      return rawData["dart_target"] as String;
    } catch (e) {
      return null;
    }
  }

  set dart_target(String? value) {
    rawData["dart_target"] = value;
  }

  String? get flutter_target {
    try {
      if (rawData["flutter_target"] is String == false) {
        return null;
      }
      return rawData["flutter_target"] as String;
    } catch (e) {
      return null;
    }
  }

  set flutter_target(String? value) {
    rawData["flutter_target"] = value;
  }

  String? get dart_name {
    try {
      if (rawData["dart_name"] is String == false) {
        return null;
      }
      return rawData["dart_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set dart_name(String? value) {
    rawData["dart_name"] = value;
  }

  String? get flutter_name {
    try {
      if (rawData["flutter_name"] is String == false) {
        return null;
      }
      return rawData["flutter_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set flutter_name(String? value) {
    rawData["flutter_name"] = value;
  }

  bool? get is_without_platform_name {
    try {
      if (rawData["is_without_platform_name"] is bool == false) {
        return null;
      }
      return rawData["is_without_platform_name"] as bool;
    } catch (e) {
      return null;
    }
  }

  set is_without_platform_name(bool? value) {
    rawData["is_without_platform_name"] = value;
  }

  PackagexConfigFlutterCommands get flutter_commands {
    try {
      if (rawData["flutter_commands"] is Map == false) {
        return PackagexConfigFlutterCommands({});
      }
      return PackagexConfigFlutterCommands(rawData["flutter_commands"] as Map);
    } catch (e) {
      return PackagexConfigFlutterCommands({});
    }
  }

  set flutter_commands(PackagexConfigFlutterCommands value) {
    rawData["flutter_commands"] = value.toJson();
  }

  String? get project_id {
    try {
      if (rawData["project_id"] is String == false) {
        return null;
      }
      return rawData["project_id"] as String;
    } catch (e) {
      return null;
    }
  }

  set project_id(String? value) {
    rawData["project_id"] = value;
  }

  String? get github_username {
    try {
      if (rawData["github_username"] is String == false) {
        return null;
      }
      return rawData["github_username"] as String;
    } catch (e) {
      return null;
    }
  }

  set github_username(String? value) {
    rawData["github_username"] = value;
  }

  bool? get github_is_org {
    try {
      if (rawData["github_is_org"] is bool == false) {
        return null;
      }
      return rawData["github_is_org"] as bool;
    } catch (e) {
      return null;
    }
  }

  set github_is_org(bool? value) {
    rawData["github_is_org"] = value;
  }

  static PackagexConfig create({
    String special_type = "packagexConfig",
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
    bool? is_without_platform_name,
    PackagexConfigFlutterCommands? flutter_commands,
    String? project_id,
    String? github_username,
    bool? github_is_org,
  }) {
    // PackagexConfig packagexConfig = PackagexConfig({
    Map packagexConfig_data_create_json = {
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
      "is_without_platform_name": is_without_platform_name,
      "flutter_commands":
          (flutter_commands != null) ? flutter_commands.toJson() : null,
      "project_id": project_id,
      "github_username": github_username,
      "github_is_org": github_is_org,
    };

    packagexConfig_data_create_json.removeWhere((key, value) => value == null);
    PackagexConfig packagexConfig_data_create =
        PackagexConfig(packagexConfig_data_create_json);

    return packagexConfig_data_create;
  }
}
