// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class BuildConfig extends JsonScheme {
  BuildConfig(super.rawData);

  /// return default data
  ///
  static Map get defaultData {
    return {
      "@type": "buildConfig",
      "name": "Pack",
      "dart_target": "",
      "flutter_target": "",
      "dart_name": "",
      "flutter_name": ""
    };
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == buildConfig
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

  /// create [BuildConfig]
  /// Empty
  static BuildConfig empty() {
    return BuildConfig({});
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

  static BuildConfig create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "buildConfig",
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
  }) {
    // BuildConfig buildConfig = BuildConfig({
    final Map buildConfig_data_create_json = {
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
    };

    buildConfig_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (buildConfig_data_create_json.containsKey(key) == false) {
          buildConfig_data_create_json[key] = value;
        }
      });
    }
    return BuildConfig(buildConfig_data_create_json);
  }
}
