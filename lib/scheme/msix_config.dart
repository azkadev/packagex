// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class MsixConfig extends JsonScheme {
  MsixConfig(super.rawData);

  static Map get defaultData {
    return {
      "@type": "msix_config",
      "display_name": "example",
      "publisher_display_name": "Azkadev Packagex",
      "identity_name": "org.azkadev.example",
      "msix_version": "0.0.0.0",
      "logo_path": "example/bin/example.dart",
      "capabilities": "internetClient, location, microphone, webcam"
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

  static MsixConfig create({
    String special_type = "msix_config",
    String? display_name,
    String? publisher_display_name,
    String? identity_name,
    String? msix_version,
    String? logo_path,
    String? capabilities,
  }) {
    // MsixConfig msixConfig = MsixConfig({
    Map msixConfig_data_create_json = {
      "@type": special_type,
      "display_name": display_name,
      "publisher_display_name": publisher_display_name,
      "identity_name": identity_name,
      "msix_version": msix_version,
      "logo_path": logo_path,
      "capabilities": capabilities,
    };

    msixConfig_data_create_json.removeWhere((key, value) => value == null);
    MsixConfig msixConfig_data_create = MsixConfig(msixConfig_data_create_json);

    return msixConfig_data_create;
  }
}
