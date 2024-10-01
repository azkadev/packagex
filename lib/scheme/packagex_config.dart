// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_config_flutter_commands.dart";

 
class PackagexConfig extends JsonScheme {

  
  PackagexConfig(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"packagexConfig","name":"Pack","dart_target":"","flutter_target":"","dart_name":"","flutter_name":"","is_without_platform_name":true,"is_app_auto_clean_up_folder":false,"flutter_commands":{"@type":"packagexConfigFlutterCommands","obfuscate":true,"split-debug-info":"0.0.5","build-name":"0.0.5","build-number":40,"split-per-abi":true,"no-tree-shake-icons":true},"project_id":"","github_username":"","github_is_org":true};
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


  
  String? get dart_target {
    try {
      if (rawData["dart_target"] is String == false){
        return null;
      }
      return rawData["dart_target"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set dart_target(String? value) {
    rawData["dart_target"] = value;
  }


  
  String? get flutter_target {
    try {
      if (rawData["flutter_target"] is String == false){
        return null;
      }
      return rawData["flutter_target"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set flutter_target(String? value) {
    rawData["flutter_target"] = value;
  }


  
  String? get dart_name {
    try {
      if (rawData["dart_name"] is String == false){
        return null;
      }
      return rawData["dart_name"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set dart_name(String? value) {
    rawData["dart_name"] = value;
  }


  
  String? get flutter_name {
    try {
      if (rawData["flutter_name"] is String == false){
        return null;
      }
      return rawData["flutter_name"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set flutter_name(String? value) {
    rawData["flutter_name"] = value;
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



  
  String? get project_id {
    try {
      if (rawData["project_id"] is String == false){
        return null;
      }
      return rawData["project_id"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set project_id(String? value) {
    rawData["project_id"] = value;
  }


  
  String? get github_username {
    try {
      if (rawData["github_username"] is String == false){
        return null;
      }
      return rawData["github_username"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set github_username(String? value) {
    rawData["github_username"] = value;
  }


  
  bool? get github_is_org {
    try {
      if (rawData["github_is_org"] is bool == false){
        return null;
      }
      return rawData["github_is_org"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set github_is_org(bool? value) {
    rawData["github_is_org"] = value;
  }


  
  static PackagexConfig create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "packagexConfig",
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
    bool? is_without_platform_name,
    bool? is_app_auto_clean_up_folder,
      PackagexConfigFlutterCommands? flutter_commands,
    String? project_id,
    String? github_username,
    bool? github_is_org,
})  {
    // PackagexConfig packagexConfig = PackagexConfig({
final Map packagexConfig_data_create_json = {
  
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
      "is_without_platform_name": is_without_platform_name,
      "is_app_auto_clean_up_folder": is_app_auto_clean_up_folder,
      "flutter_commands": (flutter_commands != null)?flutter_commands.toJson(): null,
      "project_id": project_id,
      "github_username": github_username,
      "github_is_org": github_is_org,


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