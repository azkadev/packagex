// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class PackagexConfigFlutterCommands extends JsonScheme {
  PackagexConfigFlutterCommands(super.rawData);

  /// return default data
  ///
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

  /// check data
  /// if raw data
  /// - rawData["@type"] == packagexConfigFlutterCommands
  /// if same return true
  bool json_scheme_utils_checkDataIsSameBySpecialType() {
    return rawData["@type"] == defaultData["@type"];
  }

  /// check value data whatever do yout want
  bool json_scheme_utils_checkDataIsSameBuilder({
    required bool Function(Map rawData, Map defaultData) onResult,
  }) {
    return onResult(rawData["@type"], defaultData["@type"]);
  }

  /// create [PackagexConfigFlutterCommands]
  /// Empty
  static PackagexConfigFlutterCommands empty() {
    return PackagexConfigFlutterCommands({});
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
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "packagexConfigFlutterCommands",
    bool? obfuscate,
    String? split_debug_info,
    String? build_name,
    num? build_number,
    bool? split_per_abi,
    bool? no_tree_shake_icons,
  }) {
    // PackagexConfigFlutterCommands packagexConfigFlutterCommands = PackagexConfigFlutterCommands({
    final Map packagexConfigFlutterCommands_data_create_json = {
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

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexConfigFlutterCommands_data_create_json.containsKey(key) ==
            false) {
          packagexConfigFlutterCommands_data_create_json[key] = value;
        }
      });
    }
    return PackagexConfigFlutterCommands(
        packagexConfigFlutterCommands_data_create_json);
  }
}
