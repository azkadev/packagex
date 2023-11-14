// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

import "dependencies_extra.dart";

class Dependencies extends JsonDart {
  Dependencies(super.rawData);

  static Map get defaultData {
    return {
      "@type": "dependencies",
      "flutter": {"@type": "dependencies_extra", "sdk": "flutter"},
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

  DependenciesExtra get flutter {
    try {
      if (rawData["flutter"] is Map == false) {
        return DependenciesExtra({});
      }
      return DependenciesExtra(rawData["flutter"] as Map);
    } catch (e) {
      return DependenciesExtra({});
    }
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

  static Dependencies create({
    String? special_type,
    DependenciesExtra? flutter,
    String? cupertino_icons,
  }) {
    Dependencies dependencies = Dependencies({
      "@type": special_type,
      "flutter": (flutter != null) ? flutter.toJson() : null,
      "cupertino_icons": cupertino_icons,
    });

    return dependencies;
  }
}
