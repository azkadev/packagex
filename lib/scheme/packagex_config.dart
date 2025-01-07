// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_config_flutter_commands.dart";
import "packagex_config_upload.dart";
import "packagex_config_package.dart";

 
class PackagexConfig extends JsonScheme {

  
  PackagexConfig(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"packagexConfig","name":"Pack","is_without_platform_name":true,"is_app_auto_clean_up_folder":false,"flutter_commands":{"@type":"packagexConfigFlutterCommands","obfuscate":true,"split-debug-info":"0.0.5","build-name":"0.0.5","build-number":40,"split-per-abi":true,"no-tree-shake-icons":true},"uploads":[{"@type":"packagexConfigUpload","platform_type":"","github_username":"","github_tag":"","github_is_org":false,"github_repository_name":"","supabase_folder_name":"","telegram_chats":[{"@type":"packagexConfigUploadTelegramChat","chat_id":"","message_thread_id":""}]}],"packages":[{"@type":"packagexConfigPackage","dart_target":"packagex","flutter_target":"main","dart_name":"packagex","flutter_name":"packagex","output_name":"packagex"}]};
  }

  /// check data 
  /// if raw data 
  /// - rawData["@type"] == packagexConfig
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

  

  /// create [PackagexConfig]
  /// Empty  
  static PackagexConfig empty() {
    return PackagexConfig({});
  }

  

  
  String? get special_type {
    try {
      if (rawData["@type"] is String == false){
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


  
  String? get name {
    try {
      if (rawData["name"] is String == false){
        return null;
      }
      return rawData["name"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set name(String? value) {
    rawData["name"] = value;
  }


  
  bool? get is_without_platform_name {
    try {
      if (rawData["is_without_platform_name"] is bool == false){
        return null;
      }
      return rawData["is_without_platform_name"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set is_without_platform_name(bool? value) {
    rawData["is_without_platform_name"] = value;
  }


  
  bool? get is_app_auto_clean_up_folder {
    try {
      if (rawData["is_app_auto_clean_up_folder"] is bool == false){
        return null;
      }
      return rawData["is_app_auto_clean_up_folder"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set is_app_auto_clean_up_folder(bool? value) {
    rawData["is_app_auto_clean_up_folder"] = value;
  }


  
  PackagexConfigFlutterCommands get flutter_commands {
    try {
      if (rawData["flutter_commands"] is Map == false){
        return PackagexConfigFlutterCommands({}); 
      }
      return PackagexConfigFlutterCommands(rawData["flutter_commands"] as Map);
    } catch (e) {  
      return PackagexConfigFlutterCommands({}); 
    }
  }


  
  set flutter_commands(PackagexConfigFlutterCommands value) {
    rawData["flutter_commands"] = value.toJson();
  }


  
  List<PackagexConfigUpload> get uploads {
    try {
      if (rawData["uploads"] is List == false){
        return [];
      }
      return (rawData["uploads"] as List).map((e) => PackagexConfigUpload(e as Map)).toList().cast<PackagexConfigUpload>();
    } catch (e) {
      return [];
    }
  }


  
  set uploads(List<PackagexConfigUpload> values) {
    rawData["uploads"] = values.map((value) => value.toJson()).toList();
  }


  
  List<PackagexConfigPackage> get packages {
    try {
      if (rawData["packages"] is List == false){
        return [];
      }
      return (rawData["packages"] as List).map((e) => PackagexConfigPackage(e as Map)).toList().cast<PackagexConfigPackage>();
    } catch (e) {
      return [];
    }
  }


  
  set packages(List<PackagexConfigPackage> values) {
    rawData["packages"] = values.map((value) => value.toJson()).toList();
  }



  
  static PackagexConfig create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "packagexConfig",
    String? name,
    bool? is_without_platform_name,
    bool? is_app_auto_clean_up_folder,
      PackagexConfigFlutterCommands? flutter_commands,
      List<PackagexConfigUpload>? uploads,
      List<PackagexConfigPackage>? packages,
})  {
    // PackagexConfig packagexConfig = PackagexConfig({
final Map packagexConfig_data_create_json = {
  
      "@type": special_type,
      "name": name,
      "is_without_platform_name": is_without_platform_name,
      "is_app_auto_clean_up_folder": is_app_auto_clean_up_folder,
      "flutter_commands": (flutter_commands != null)?flutter_commands.toJson(): null,
      "uploads": (uploads != null)? uploads.toJson(): null,
      "packages": (packages != null)? packages.toJson(): null,


};


          packagexConfig_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexConfig_data_create_json.containsKey(key) == false) {
          packagexConfig_data_create_json[key] = value;
        }
      });
    }
return PackagexConfig(packagexConfig_data_create_json);


      }
}