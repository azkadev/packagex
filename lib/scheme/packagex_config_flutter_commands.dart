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

class PackagexConfigFlutterCommands extends JsonScheme {
  PackagexConfigFlutterCommands(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexConfigFlutterCommands",
      "obfuscate": true,
      "split-debug-info": "0.0.5",
      "build-name": "0.0.5",
      "build-number": 40,
      "split-per-abi": true,
      "no-tree-shake-icons": true
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

  bool? get obfuscate {
    try {
      if (rawData["obfuscate"] is bool == false) {
        return null;
      }
      return rawData["obfuscate"] as bool;
    } catch (e) {
      return null;
    }
  }

  set obfuscate(bool? value) {
    rawData["obfuscate"] = value;
  }

  String? get split_debug_info {
    try {
      if (rawData["split-debug-info"] is String == false) {
        return null;
      }
      return rawData["split-debug-info"] as String;
    } catch (e) {
      return null;
    }
  }

  set split_debug_info(String? value) {
    rawData["split-debug-info"] = value;
  }

  String? get build_name {
    try {
      if (rawData["build-name"] is String == false) {
        return null;
      }
      return rawData["build-name"] as String;
    } catch (e) {
      return null;
    }
  }

  set build_name(String? value) {
    rawData["build-name"] = value;
  }

  num? get build_number {
    try {
      if (rawData["build-number"] is num == false) {
        return null;
      }
      return rawData["build-number"] as num;
    } catch (e) {
      return null;
    }
  }

  set build_number(num? value) {
    rawData["build-number"] = value;
  }

  bool? get split_per_abi {
    try {
      if (rawData["split-per-abi"] is bool == false) {
        return null;
      }
      return rawData["split-per-abi"] as bool;
    } catch (e) {
      return null;
    }
  }

  set split_per_abi(bool? value) {
    rawData["split-per-abi"] = value;
  }

  bool? get no_tree_shake_icons {
    try {
      if (rawData["no-tree-shake-icons"] is bool == false) {
        return null;
      }
      return rawData["no-tree-shake-icons"] as bool;
    } catch (e) {
      return null;
    }
  }

  set no_tree_shake_icons(bool? value) {
    rawData["no-tree-shake-icons"] = value;
  }

  static PackagexConfigFlutterCommands create({
    String special_type = "packagexConfigFlutterCommands",
    bool? obfuscate,
    String? split_debug_info,
    String? build_name,
    num? build_number,
    bool? split_per_abi,
    bool? no_tree_shake_icons,
  }) {
    // PackagexConfigFlutterCommands packagexConfigFlutterCommands = PackagexConfigFlutterCommands({
    Map packagexConfigFlutterCommands_data_create_json = {
      "@type": special_type,
      "obfuscate": obfuscate,
      "split-debug-info": split_debug_info,
      "build-name": build_name,
      "build-number": build_number,
      "split-per-abi": split_per_abi,
      "no-tree-shake-icons": no_tree_shake_icons,
    };

    packagexConfigFlutterCommands_data_create_json
        .removeWhere((key, value) => value == null);
    PackagexConfigFlutterCommands packagexConfigFlutterCommands_data_create =
        PackagexConfigFlutterCommands(
            packagexConfigFlutterCommands_data_create_json);

    return packagexConfigFlutterCommands_data_create;
  }
}
