// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class DevDependenciesExtra extends JsonScheme {
  DevDependenciesExtra(super.rawData);

  static Map get defaultData {
    return {"@type": "dev_dependencies_extra", "path": "../"};
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

  static DevDependenciesExtra create({
    String special_type = "dev_dependencies_extra",
    String? path,
  }) {
    // DevDependenciesExtra devDependenciesExtra = DevDependenciesExtra({
    Map devDependenciesExtra_data_create_json = {
      "@type": special_type,
      "path": path,
    };

    devDependenciesExtra_data_create_json
        .removeWhere((key, value) => value == null);
    DevDependenciesExtra devDependenciesExtra_data_create =
        DevDependenciesExtra(devDependenciesExtra_data_create_json);

    return devDependenciesExtra_data_create;
  }
}
