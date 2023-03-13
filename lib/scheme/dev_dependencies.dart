// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

import "dev_dependencies_extra.dart";


class DevDependencies extends JsonDart {

  
  DevDependencies(super.rawData);
   
  static Map get defaultData {
    return {"@type":"dev_dependencies","lints":"^2.0.0","test":"^1.16.0","packagex":{"@type":"dev_dependencies_extra","path":"../"}};
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


  
  String? get lints {
    try {
      if (rawData["lints"] is String == false){
        return null;
      }
      return rawData["lints"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get test {
    try {
      if (rawData["test"] is String == false){
        return null;
      }
      return rawData["test"] as String;
    } catch (e) {
      return null;
    }
  }


  
  DevDependenciesExtra get packagex {
    try {
      if (rawData["packagex"] is Map == false){
        return DevDependenciesExtra({}); 
      }
      return DevDependenciesExtra(rawData["packagex"] as Map);
    } catch (e) {  
      return DevDependenciesExtra({}); 
    }
  }


  
  static DevDependencies create({

    String? special_type,
    String? lints,
    String? test,
      DevDependenciesExtra? packagex,
})  {
    DevDependencies devDependencies = DevDependencies({
  
      "@type": special_type,
      "lints": lints,
      "test": test,
      "packagex": (packagex != null)?packagex.toJson(): null,


  });


return devDependencies;

      }
}