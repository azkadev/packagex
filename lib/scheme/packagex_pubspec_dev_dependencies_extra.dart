// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class PackagexPubspecDevDependenciesExtra extends JsonScheme {
  PackagexPubspecDevDependenciesExtra(super.rawData);

  /// return default data
  ///
  static Map get defaultData {
    return {"@type": "packagexPubspecDevDependenciesExtra", "path": "../"};
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == packagexPubspecDevDependenciesExtra
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

  /// create [PackagexPubspecDevDependenciesExtra]
  /// Empty
  static PackagexPubspecDevDependenciesExtra empty() {
    return PackagexPubspecDevDependenciesExtra({});
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

  String? get path {
    try {
      if (rawData["path"] is String == false) {
        return null;
      }
      return rawData["path"] as String;
    } catch (e) {
      return null;
    }
  }

  set path(String? value) {
    rawData["path"] = value;
  }

  static PackagexPubspecDevDependenciesExtra create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "packagexPubspecDevDependenciesExtra",
    String? path,
  }) {
    // PackagexPubspecDevDependenciesExtra packagexPubspecDevDependenciesExtra = PackagexPubspecDevDependenciesExtra({
    final Map packagexPubspecDevDependenciesExtra_data_create_json = {
      "@type": special_type,
      "path": path,
    };

    packagexPubspecDevDependenciesExtra_data_create_json
        .removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexPubspecDevDependenciesExtra_data_create_json
                .containsKey(key) ==
            false) {
          packagexPubspecDevDependenciesExtra_data_create_json[key] = value;
        }
      });
    }
    return PackagexPubspecDevDependenciesExtra(
        packagexPubspecDevDependenciesExtra_data_create_json);
  }
}
