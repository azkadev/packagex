// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class Environment extends JsonScheme {
  Environment(super.rawData);

  static Map get defaultData {
    return {"@type": "environment", "sdk": ">=2.18.5 <3.0.0"};
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

  String? get sdk {
    try {
      if (rawData["sdk"] is String == false) {
        return null;
      }
      return rawData["sdk"] as String;
    } catch (e) {
      return null;
    }
  }

  static Environment create({
    String special_type = "environment",
    String? sdk,
  }) {
    // Environment environment = Environment({
    Map environment_data_create_json = {
      "@type": special_type,
      "sdk": sdk,
    };

    environment_data_create_json.removeWhere((key, value) => value == null);
    Environment environment_data_create =
        Environment(environment_data_create_json);

    return environment_data_create;
  }
}
