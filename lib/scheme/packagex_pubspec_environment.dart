// ignore_for_file: non_constant_identifier_names,
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class PackagexPubspecEnvironment extends JsonScheme {
  PackagexPubspecEnvironment(super.rawData);

  static Map get defaultData {
    return {"@type": "packagexPubspecEnvironment", "sdk": ">=2.18.5 <3.0.0"};
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

  static PackagexPubspecEnvironment create({
    String special_type = "packagexPubspecEnvironment",
    String? sdk,
  }) {
    // PackagexPubspecEnvironment packagexPubspecEnvironment = PackagexPubspecEnvironment({
    Map packagexPubspecEnvironment_data_create_json = {
      "@type": special_type,
      "sdk": sdk,
    };

    packagexPubspecEnvironment_data_create_json
        .removeWhere((key, value) => value == null);
    PackagexPubspecEnvironment packagexPubspecEnvironment_data_create =
        PackagexPubspecEnvironment(packagexPubspecEnvironment_data_create_json);

    return packagexPubspecEnvironment_data_create;
  }
}
