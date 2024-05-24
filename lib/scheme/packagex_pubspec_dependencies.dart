// ignore_for_file: non_constant_identifier_names,
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_pubspec_dependencies_extra.dart";

class PackagexPubspecDependencies extends JsonScheme {
  PackagexPubspecDependencies(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexPubspecDependencies",
      "flutter": {
        "@type": "packagexPubspecDependenciesExtra",
        "sdk": "flutter"
      },
      "cupertino_icons": "^1.0.2"
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

  PackagexPubspecDependenciesExtra get flutter {
    try {
      if (rawData["flutter"] is Map == false) {
        return PackagexPubspecDependenciesExtra({});
      }
      return PackagexPubspecDependenciesExtra(rawData["flutter"] as Map);
    } catch (e) {
      return PackagexPubspecDependenciesExtra({});
    }
  }

  set flutter(PackagexPubspecDependenciesExtra value) {
    rawData["flutter"] = value.toJson();
  }

  String? get cupertino_icons {
    try {
      if (rawData["cupertino_icons"] is String == false) {
        return null;
      }
      return rawData["cupertino_icons"] as String;
    } catch (e) {
      return null;
    }
  }

  set cupertino_icons(String? value) {
    rawData["cupertino_icons"] = value;
  }

  static PackagexPubspecDependencies create({
    String special_type = "packagexPubspecDependencies",
    PackagexPubspecDependenciesExtra? flutter,
    String? cupertino_icons,
  }) {
    // PackagexPubspecDependencies packagexPubspecDependencies = PackagexPubspecDependencies({
    Map packagexPubspecDependencies_data_create_json = {
      "@type": special_type,
      "flutter": (flutter != null) ? flutter.toJson() : null,
      "cupertino_icons": cupertino_icons,
    };

    packagexPubspecDependencies_data_create_json
        .removeWhere((key, value) => value == null);
    PackagexPubspecDependencies packagexPubspecDependencies_data_create =
        PackagexPubspecDependencies(
            packagexPubspecDependencies_data_create_json);

    return packagexPubspecDependencies_data_create;
  }
}
