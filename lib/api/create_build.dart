// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

import "build_config.dart";


class CreateBuild extends JsonDart {

  
  CreateBuild(super.rawData);
   
  static Map get defaultData {
    return {"@type":"createBuild","platform":"","path_current":"","path_output":"","build_config":{"@type":"buildConfig","name":"Pack","dart_target":"","flutter_target":"","dart_name":"","flutter_name":""}};
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


  
  static CreateBuild create({

    String? special_type,
    String? platform,
    String? path_current,
    String? path_output,
      BuildConfig? build_config,
})  {
    CreateBuild createBuild = CreateBuild({
  
      "@type": special_type,
      "platform": platform,
      "path_current": path_current,
      "path_output": path_output,
      "build_config": (build_config != null)?build_config.toJson(): null,


  });


return createBuild;

      }
}