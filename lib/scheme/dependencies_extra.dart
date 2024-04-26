// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class DependenciesExtra extends JsonScheme {
  DependenciesExtra(super.rawData);

  static Map get defaultData {
    return {"@type": "dependencies_extra", "sdk": "flutter"};
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

  set sdk(String? value) {
    rawData["sdk"] = value;
  }

  static DependenciesExtra create({
    String special_type = "dependencies_extra",
    String? sdk,
  }) {
    // DependenciesExtra dependenciesExtra = DependenciesExtra({
    Map dependenciesExtra_data_create_json = {
      "@type": special_type,
      "sdk": sdk,
    };

    dependenciesExtra_data_create_json.removeWhere((key, value) => value == null);
    DependenciesExtra dependenciesExtra_data_create = DependenciesExtra(dependenciesExtra_data_create_json);

    return dependenciesExtra_data_create;
  }
}
