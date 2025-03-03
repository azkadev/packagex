// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_config_upload_telegram_chat.dart";

/// Generated
class PackagexConfigUpload extends JsonScheme {
  /// Generated
  PackagexConfigUpload(super.rawData);

  /// return default special type @type
  /// "packagexConfigUpload"
  static String get defaultDataSpecialType {
    return "packagexConfigUpload";
  }

  /// return default data
  ///
  static Map get defaultData {
    return {
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
    };
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == packagexConfigUpload
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

  /// create [PackagexConfigUpload]
  /// Empty
  static PackagexConfigUpload empty() {
    return PackagexConfigUpload({});
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
  String? get platform_type {
    try {
      if (rawData["platform_type"] is String == false) {
        return null;
      }
      return rawData["platform_type"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set platform_type(String? value) {
    rawData["platform_type"] = value;
  }

  /// Generated
  String? get github_username {
    try {
      if (rawData["github_username"] is String == false) {
        return null;
      }
      return rawData["github_username"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set github_username(String? value) {
    rawData["github_username"] = value;
  }

  /// Generated
  String? get github_tag {
    try {
      if (rawData["github_tag"] is String == false) {
        return null;
      }
      return rawData["github_tag"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set github_tag(String? value) {
    rawData["github_tag"] = value;
  }

  /// Generated
  bool? get github_is_org {
    try {
      if (rawData["github_is_org"] is bool == false) {
        return null;
      }
      return rawData["github_is_org"] as bool;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set github_is_org(bool? value) {
    rawData["github_is_org"] = value;
  }

  /// Generated
  String? get github_repository_name {
    try {
      if (rawData["github_repository_name"] is String == false) {
        return null;
      }
      return rawData["github_repository_name"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set github_repository_name(String? value) {
    rawData["github_repository_name"] = value;
  }

  /// Generated
  String? get supabase_folder_name {
    try {
      if (rawData["supabase_folder_name"] is String == false) {
        return null;
      }
      return rawData["supabase_folder_name"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set supabase_folder_name(String? value) {
    rawData["supabase_folder_name"] = value;
  }

  /// Generated
  List<PackagexConfigUploadTelegramChat> get telegram_chats {
    try {
      if (rawData["telegram_chats"] is List == false) {
        return [];
      }
      return (rawData["telegram_chats"] as List)
          .map((e) => PackagexConfigUploadTelegramChat(e as Map))
          .toList()
          .cast<PackagexConfigUploadTelegramChat>();
    } catch (e) {
      return [];
    }
  }

  /// Generated
  set telegram_chats(List<PackagexConfigUploadTelegramChat> values) {
    rawData["telegram_chats"] = values.map((value) => value.toJson()).toList();
  }

  /// Generated
  static PackagexConfigUpload create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "packagexConfigUpload",
    String? platform_type,
    String? github_username,
    String? github_tag,
    bool? github_is_org,
    String? github_repository_name,
    String? supabase_folder_name,
    List<PackagexConfigUploadTelegramChat>? telegram_chats,
  }) {
    // PackagexConfigUpload packagexConfigUpload = PackagexConfigUpload({
    final Map packagexConfigUpload_data_create_json = {
      "@type": special_type,
      "platform_type": platform_type,
      "github_username": github_username,
      "github_tag": github_tag,
      "github_is_org": github_is_org,
      "github_repository_name": github_repository_name,
      "supabase_folder_name": supabase_folder_name,
      "telegram_chats":
          (telegram_chats != null) ? telegram_chats.toJson() : null,
    };

    packagexConfigUpload_data_create_json
        .removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexConfigUpload_data_create_json.containsKey(key) == false) {
          packagexConfigUpload_data_create_json[key] = value;
        }
      });
    }
    return PackagexConfigUpload(packagexConfigUpload_data_create_json);
  }
}
