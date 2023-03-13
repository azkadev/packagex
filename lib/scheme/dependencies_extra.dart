// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class DependenciesExtra extends JsonDart {

  
  DependenciesExtra(super.rawData);
   
  static Map get defaultData {
    return {"@type":"dependencies_extra","sdk":"flutter"};
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


  
  String? get sdk {
    try {
      if (rawData["sdk"] is String == false){
        return null;
      }
      return rawData["sdk"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static DependenciesExtra create({

    String? special_type,
    String? sdk,
})  {
    DependenciesExtra dependenciesExtra = DependenciesExtra({
  
      "@type": special_type,
      "sdk": sdk,


  });


return dependenciesExtra;

      }
}