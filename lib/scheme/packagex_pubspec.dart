// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_pubspec_platforms.dart";
import "packagex_pubspec_environment.dart";
import "packagex_pubspec_dependencies.dart";
import "packagex_pubspec_dev_dependencies.dart";
import "packagex_config.dart";
import "packagex_msix_config.dart";

/// Generated
class PackagexPubspec extends JsonScheme {
  /// Generated
  PackagexPubspec(super.rawData);

  /// return default special type @type
  /// "packagexPubspec"
  static String get defaultDataSpecialType {
    return "packagexPubspec";
  }

  /// return default data
  ///
  static Map get defaultData {
    return {
      "@type": "packagexPubspec",
      "name": "example",
      "description": "A sample command-line application.",
      "version": "0.0.0",
      "publish_to": "none",
      "homepage": "https://youtube.com/@azkadev",
      "repository": "https://github.com/azkadev/packagex.git",
      "platforms": {
        "@type": "packagexPubspecPlatforms",
        "android": null,
        "ios": null,
        "linux": null,
        "macos": null,
        "web": null,
        "windows": null,
      },
      "environment": {
        "@type": "packagexPubspecEnvironment",
        "sdk": ">=2.18.5 <3.0.0",
      },
      "dependencies": {
        "@type": "packagexPubspecDependencies",
        "flutter": {
          "@type": "packagexPubspecDependenciesExtra",
          "sdk": "flutter",
        },
        "cupertino_icons": "^1.0.2",
      },
      "dev_dependencies": {
        "@type": "packagexPubspecDevDependencies",
        "lints": "^2.0.0",
        "test": "^1.16.0",
        "packagex": {
          "@type": "packagexPubspecDevDependenciesExtra",
          "path": "../",
        },
        "msix": "^1.0.6",
      },
      "packagex": {
        "@type": "packagexConfig",
        "name": "Pack",
        "is_without_platform_name": true,
        "is_app_auto_clean_up_folder": false,
        "flutter_build_arguments": ["--split-per-abi", "--obfuscate"],
        "dart_compile_exe_arguments": [
          "--save-debugging-info=debug",
          "--target-os",
          "linux",
        ],
        "uploads": [
          {
            "@type": "packagexConfigUpload",
            "platform_type": "",
            "github_username": "",
            "github_tag": "",
            "github_is_org": false,
            "github_repository_name": "",
            "supabase_folder_name": "",
            "telegram_chats": [
              {
                "@type": "packagexConfigUploadTelegramChat",
                "chat_id": "",
                "message_thread_id": "",
              }
            ],
          }
        ],
        "packages": [
          {
            "@type": "packagexConfigPackage",
            "dart_target": "packagex",
            "flutter_target": "main",
            "dart_name": "packagex",
            "flutter_name": "packagex",
            "output_name": "packagex",
          }
        ],
      },
      "msix_config": {
        "@type": "packagexMsixConfig",
        "display_name": "example",
        "publisher_display_name": "Azkadev Packagex",
        "identity_name": "org.azkadev.example",
        "msix_version": "0.0.0.0",
        "logo_path": "example/bin/example.dart",
        "capabilities": "internetClient, location, microphone, webcam",
        "install_certificate": false,
      },
    };
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == packagexPubspec
  /// if same return true
  bool json_scheme_utils_checkDataIsSameBySpecialType() {
    return rawData["@type"] == defaultData["@type"];
  }

  /// check value data whatever do yout want
  bool json_scheme_utils_checkDataIsSameBuilder({
    required bool Function(Map rawData, Map defaultData) onResult,
  }) {
    return onResult(rawData["@type"], defaultData["@type"]);
  }

  /// create [PackagexPubspec]
  /// Empty
  static PackagexPubspec empty() {
    return PackagexPubspec({});
  }

  /// Generated
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

  /// Generated
  set special_type(String? value) {
    rawData["@type"] = value;
  }

  /// Generated
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

  /// Generated
  set name(String? value) {
    rawData["name"] = value;
  }

  /// Generated
  String? get description {
    try {
      if (rawData["description"] is String == false) {
        return null;
      }
      return rawData["description"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set description(String? value) {
    rawData["description"] = value;
  }

  /// Generated
  String? get version {
    try {
      if (rawData["version"] is String == false) {
        return null;
      }
      return rawData["version"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set version(String? value) {
    rawData["version"] = value;
  }

  /// Generated
  String? get publish_to {
    try {
      if (rawData["publish_to"] is String == false) {
        return null;
      }
      return rawData["publish_to"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set publish_to(String? value) {
    rawData["publish_to"] = value;
  }

  /// Generated
  String? get homepage {
    try {
      if (rawData["homepage"] is String == false) {
        return null;
      }
      return rawData["homepage"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set homepage(String? value) {
    rawData["homepage"] = value;
  }

  /// Generated
  String? get repository {
    try {
      if (rawData["repository"] is String == false) {
        return null;
      }
      return rawData["repository"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set repository(String? value) {
    rawData["repository"] = value;
  }

  /// Generated
  PackagexPubspecPlatforms get platforms {
    try {
      if (rawData["platforms"] is Map == false) {
        return PackagexPubspecPlatforms({});
      }
      return PackagexPubspecPlatforms(rawData["platforms"] as Map);
    } catch (e) {
      return PackagexPubspecPlatforms({});
    }
  }

  /// Generated
  set platforms(PackagexPubspecPlatforms value) {
    rawData["platforms"] = value.toJson();
  }

  /// Generated
  PackagexPubspecEnvironment get environment {
    try {
      if (rawData["environment"] is Map == false) {
        return PackagexPubspecEnvironment({});
      }
      return PackagexPubspecEnvironment(rawData["environment"] as Map);
    } catch (e) {
      return PackagexPubspecEnvironment({});
    }
  }

  /// Generated
  set environment(PackagexPubspecEnvironment value) {
    rawData["environment"] = value.toJson();
  }

  /// Generated
  PackagexPubspecDependencies get dependencies {
    try {
      if (rawData["dependencies"] is Map == false) {
        return PackagexPubspecDependencies({});
      }
      return PackagexPubspecDependencies(rawData["dependencies"] as Map);
    } catch (e) {
      return PackagexPubspecDependencies({});
    }
  }

  /// Generated
  set dependencies(PackagexPubspecDependencies value) {
    rawData["dependencies"] = value.toJson();
  }

  /// Generated
  PackagexPubspecDevDependencies get dev_dependencies {
    try {
      if (rawData["dev_dependencies"] is Map == false) {
        return PackagexPubspecDevDependencies({});
      }
      return PackagexPubspecDevDependencies(rawData["dev_dependencies"] as Map);
    } catch (e) {
      return PackagexPubspecDevDependencies({});
    }
  }

  /// Generated
  set dev_dependencies(PackagexPubspecDevDependencies value) {
    rawData["dev_dependencies"] = value.toJson();
  }

  /// Generated
  PackagexConfig get packagex {
    try {
      if (rawData["packagex"] is Map == false) {
        return PackagexConfig({});
      }
      return PackagexConfig(rawData["packagex"] as Map);
    } catch (e) {
      return PackagexConfig({});
    }
  }

  /// Generated
  set packagex(PackagexConfig value) {
    rawData["packagex"] = value.toJson();
  }

  /// Generated
  PackagexMsixConfig get msix_config {
    try {
      if (rawData["msix_config"] is Map == false) {
        return PackagexMsixConfig({});
      }
      return PackagexMsixConfig(rawData["msix_config"] as Map);
    } catch (e) {
      return PackagexMsixConfig({});
    }
  }

  /// Generated
  set msix_config(PackagexMsixConfig value) {
    rawData["msix_config"] = value.toJson();
  }

  /// Generated
  static PackagexPubspec create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "packagexPubspec",
    String? name,
    String? description,
    String? version,
    String? publish_to,
    String? homepage,
    String? repository,
    PackagexPubspecPlatforms? platforms,
    PackagexPubspecEnvironment? environment,
    PackagexPubspecDependencies? dependencies,
    PackagexPubspecDevDependencies? dev_dependencies,
    PackagexConfig? packagex,
    PackagexMsixConfig? msix_config,
  }) {
    // PackagexPubspec packagexPubspec = PackagexPubspec({
    final Map packagexPubspec_data_create_json = {
      "@type": special_type,
      "name": name,
      "description": description,
      "version": version,
      "publish_to": publish_to,
      "homepage": homepage,
      "repository": repository,
      "platforms": (platforms != null) ? platforms.toJson() : null,
      "environment": (environment != null) ? environment.toJson() : null,
      "dependencies": (dependencies != null) ? dependencies.toJson() : null,
      "dev_dependencies":
          (dev_dependencies != null) ? dev_dependencies.toJson() : null,
      "packagex": (packagex != null) ? packagex.toJson() : null,
      "msix_config": (msix_config != null) ? msix_config.toJson() : null,
    };

    packagexPubspec_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexPubspec_data_create_json.containsKey(key) == false) {
          packagexPubspec_data_create_json[key] = value;
        }
      });
    }
    return PackagexPubspec(packagexPubspec_data_create_json);
  }
}
