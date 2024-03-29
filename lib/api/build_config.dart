// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class BuildConfig extends JsonScheme {
  BuildConfig(super.rawData);

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

  static BuildConfig create({
    String special_type = "buildConfig",
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
  }) {
    // BuildConfig buildConfig = BuildConfig({
    Map buildConfig_data_create_json = {
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
    };

    buildConfig_data_create_json.removeWhere((key, value) => value == null);
    BuildConfig buildConfig_data_create =
        BuildConfig(buildConfig_data_create_json);

    return buildConfig_data_create;
  }
}
