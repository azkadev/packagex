// ignore_for_file: non_constant_identifier_names,
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class PackagexMsixConfig extends JsonScheme {
  PackagexMsixConfig(super.rawData);

  static Map get defaultData {
    return {"@type": "packagexMsixConfig", "display_name": "example", "publisher_display_name": "Azkadev Packagex", "identity_name": "org.azkadev.example", "msix_version": "0.0.0.0", "logo_path": "example/bin/example.dart", "capabilities": "internetClient, location, microphone, webcam", "install_certificate": false};
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

  String? get display_name {
    try {
      if (rawData["display_name"] is String == false) {
        return null;
      }
      return rawData["display_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set display_name(String? value) {
    rawData["display_name"] = value;
  }

  String? get publisher_display_name {
    try {
      if (rawData["publisher_display_name"] is String == false) {
        return null;
      }
      return rawData["publisher_display_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set publisher_display_name(String? value) {
    rawData["publisher_display_name"] = value;
  }

  String? get identity_name {
    try {
      if (rawData["identity_name"] is String == false) {
        return null;
      }
      return rawData["identity_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set identity_name(String? value) {
    rawData["identity_name"] = value;
  }

  String? get msix_version {
    try {
      if (rawData["msix_version"] is String == false) {
        return null;
      }
      return rawData["msix_version"] as String;
    } catch (e) {
      return null;
    }
  }

  set msix_version(String? value) {
    rawData["msix_version"] = value;
  }

  String? get logo_path {
    try {
      if (rawData["logo_path"] is String == false) {
        return null;
      }
      return rawData["logo_path"] as String;
    } catch (e) {
      return null;
    }
  }

  set logo_path(String? value) {
    rawData["logo_path"] = value;
  }

  String? get capabilities {
    try {
      if (rawData["capabilities"] is String == false) {
        return null;
      }
      return rawData["capabilities"] as String;
    } catch (e) {
      return null;
    }
  }

  set capabilities(String? value) {
    rawData["capabilities"] = value;
  }

  bool? get install_certificate {
    try {
      if (rawData["install_certificate"] is bool == false) {
        return null;
      }
      return rawData["install_certificate"] as bool;
    } catch (e) {
      return null;
    }
  }

  set install_certificate(bool? value) {
    rawData["install_certificate"] = value;
  }

  static PackagexMsixConfig create({
    String special_type = "packagexMsixConfig",
    String? display_name,
    String? publisher_display_name,
    String? identity_name,
    String? msix_version,
    String? logo_path,
    String? capabilities,
    bool? install_certificate,
  }) {
    // PackagexMsixConfig packagexMsixConfig = PackagexMsixConfig({
    Map packagexMsixConfig_data_create_json = {
      "@type": special_type,
      "display_name": display_name,
      "publisher_display_name": publisher_display_name,
      "identity_name": identity_name,
      "msix_version": msix_version,
      "logo_path": logo_path,
      "capabilities": capabilities,
      "install_certificate": install_certificate,
    };

    packagexMsixConfig_data_create_json.removeWhere((key, value) => value == null);
    PackagexMsixConfig packagexMsixConfig_data_create = PackagexMsixConfig(packagexMsixConfig_data_create_json);

    return packagexMsixConfig_data_create;
  }
}
