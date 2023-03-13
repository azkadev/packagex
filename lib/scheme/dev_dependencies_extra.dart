// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class DevDependenciesExtra extends JsonDart {

  
  DevDependenciesExtra(super.rawData);
   
  static Map get defaultData {
    return {"@type":"dev_dependencies_extra","path":"../"};
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


  
  String? get path {
    try {
      if (rawData["path"] is String == false){
        return null;
      }
      return rawData["path"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static DevDependenciesExtra create({

    String? special_type,
    String? path,
})  {
    DevDependenciesExtra devDependenciesExtra = DevDependenciesExtra({
  
      "@type": special_type,
      "path": path,


  });


return devDependenciesExtra;

      }
}