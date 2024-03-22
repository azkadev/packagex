// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "flutter_commands.dart";

 
class Packagex extends JsonScheme {

  
  Packagex(super.rawData);
   
  static Map get defaultData {
    return {"@type":"packagex","name":"Pack","dart_target":"","flutter_target":"","dart_name":"","flutter_name":"","is_without_platform_name":true,"flutter_commands":{"@type":"flutter_commands","obfuscate":true,"split-debug-info":"0.0.5","build-name":"0.0.5","build-number":40,"split-per-abi":true,"no-tree-shake-icons":true},"project_id":"","github_username":"","github_is_org":true};
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


  
  FlutterCommands get flutter_commands {
    try {
      if (rawData["flutter_commands"] is Map == false){
        return FlutterCommands({}); 
      }
      return FlutterCommands(rawData["flutter_commands"] as Map);
    } catch (e) {  
      return FlutterCommands({}); 
    }
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


  
  static Packagex create({

    String special_type = "packagex",
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
    bool? is_without_platform_name,
      FlutterCommands? flutter_commands,
    String? project_id,
    String? github_username,
    bool? github_is_org,
})  {
    // Packagex packagex = Packagex({
Map packagex_data_create_json = {
  
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
      "is_without_platform_name": is_without_platform_name,
      "flutter_commands": (flutter_commands != null)?flutter_commands.toJson(): null,
      "project_id": project_id,
      "github_username": github_username,
      "github_is_org": github_is_org,


};


          packagex_data_create_json.removeWhere((key, value) => value == null);
Packagex packagex_data_create = Packagex(packagex_data_create_json);

return packagex_data_create;



      }
}