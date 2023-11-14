// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

import "flutter_commands.dart";

class Packagex extends JsonDart {
  Packagex(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagex",
      "name": "Pack",
      "dart_target": "",
      "flutter_target": "",
      "dart_name": "",
      "flutter_name": "",
      "is_without_platform_name": true,
      "flutter_commands": {
        "@type": "flutter_commands",
        "obfuscate": true,
        "split_debug_info": "0.0.5"
      }
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

  bool? get is_without_platform_name {
    try {
      if (rawData["is_without_platform_name"] is bool == false) {
        return null;
      }
      return rawData["is_without_platform_name"] as bool;
    } catch (e) {
      return null;
    }
  }

  FlutterCommands get flutter_commands {
    try {
      if (rawData["flutter_commands"] is Map == false) {
        return FlutterCommands({});
      }
      return FlutterCommands(rawData["flutter_commands"] as Map);
    } catch (e) {
      return FlutterCommands({});
    }
  }

  static Packagex create({
    String? special_type,
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
    bool? is_without_platform_name,
    FlutterCommands? flutter_commands,
  }) {
    Packagex packagex = Packagex({
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
      "is_without_platform_name": is_without_platform_name,
      "flutter_commands":
          (flutter_commands != null) ? flutter_commands.toJson() : null,
    });

    return packagex;
  }
}
