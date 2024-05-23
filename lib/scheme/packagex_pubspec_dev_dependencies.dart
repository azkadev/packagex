// ignore_for_file: non_constant_identifier_names,
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_pubspec_dev_dependencies_extra.dart";

class PackagexPubspecDevDependencies extends JsonScheme {
  PackagexPubspecDevDependencies(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexPubspecDevDependencies",
      "lints": "^2.0.0",
      "test": "^1.16.0",
      "packagex": {"@type": "packagexPubspecDevDependenciesExtra", "path": "../"},
      "msix": "^1.0.6"
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

  String? get lints {
    try {
      if (rawData["lints"] is String == false) {
        return null;
      }
      return rawData["lints"] as String;
    } catch (e) {
      return null;
    }
  }

  set lints(String? value) {
    rawData["lints"] = value;
  }

  String? get test {
    try {
      if (rawData["test"] is String == false) {
        return null;
      }
      return rawData["test"] as String;
    } catch (e) {
      return null;
    }
  }

  set test(String? value) {
    rawData["test"] = value;
  }

  PackagexPubspecDevDependenciesExtra get packagex {
    try {
      if (rawData["packagex"] is Map == false) {
        return PackagexPubspecDevDependenciesExtra({});
      }
      return PackagexPubspecDevDependenciesExtra(rawData["packagex"] as Map);
    } catch (e) {
      return PackagexPubspecDevDependenciesExtra({});
    }
  }

  set packagex(PackagexPubspecDevDependenciesExtra value) {
    rawData["packagex"] = value.toJson();
  }

  String? get msix {
    try {
      if (rawData["msix"] is String == false) {
        return null;
      }
      return rawData["msix"] as String;
    } catch (e) {
      return null;
    }
  }

  set msix(String? value) {
    rawData["msix"] = value;
  }

  static PackagexPubspecDevDependencies create({
    String special_type = "packagexPubspecDevDependencies",
    String? lints,
    String? test,
    PackagexPubspecDevDependenciesExtra? packagex,
    String? msix,
  }) {
    // PackagexPubspecDevDependencies packagexPubspecDevDependencies = PackagexPubspecDevDependencies({
    Map packagexPubspecDevDependencies_data_create_json = {
      "@type": special_type,
      "lints": lints,
      "test": test,
      "packagex": (packagex != null) ? packagex.toJson() : null,
      "msix": msix,
    };

    packagexPubspecDevDependencies_data_create_json.removeWhere((key, value) => value == null);
    PackagexPubspecDevDependencies packagexPubspecDevDependencies_data_create = PackagexPubspecDevDependencies(packagexPubspecDevDependencies_data_create_json);

    return packagexPubspecDevDependencies_data_create;
  }
}
