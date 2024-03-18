// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "build_config.dart";

 
class BuildPackage extends JsonScheme {

  
  BuildPackage(super.rawData);
   
  static Map get defaultData {
    return {"@type":"buildPackage","platform":"","path_current":"","path_output":"","build_config":{"@type":"buildConfig","name":"Pack","dart_target":"","flutter_target":"","dart_name":"","flutter_name":""}};
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


  
  String? get platform {
    try {
      if (rawData["platform"] is String == false){
        return null;
      }
      return rawData["platform"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get path_current {
    try {
      if (rawData["path_current"] is String == false){
        return null;
      }
      return rawData["path_current"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get path_output {
    try {
      if (rawData["path_output"] is String == false){
        return null;
      }
      return rawData["path_output"] as String;
    } catch (e) {
      return null;
    }
  }


  
  BuildConfig get build_config {
    try {
      if (rawData["build_config"] is Map == false){
        return BuildConfig({}); 
      }
      return BuildConfig(rawData["build_config"] as Map);
    } catch (e) {  
      return BuildConfig({}); 
    }
  }


  
  static BuildPackage create({

    String special_type = "buildPackage",
    String? platform,
    String? path_current,
    String? path_output,
      BuildConfig? build_config,
})  {
    // BuildPackage buildPackage = BuildPackage({
Map buildPackage_data_create_json = {
  
      "@type": special_type,
      "platform": platform,
      "path_current": path_current,
      "path_output": path_output,
      "build_config": (build_config != null)?build_config.toJson(): null,


};


          buildPackage_data_create_json.removeWhere((key, value) => value == null);
BuildPackage buildPackage_data_create = BuildPackage(buildPackage_data_create_json);

return buildPackage_data_create;



      }
}