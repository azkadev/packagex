// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class Environment extends JsonDart {

  
  Environment(super.rawData);
   
  static Map get defaultData {
    return {"@type":"environment","sdk":">=2.18.5 <3.0.0"};
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


  
  static Environment create({

    String? special_type,
    String? sdk,
})  {
    Environment environment = Environment({
  
      "@type": special_type,
      "sdk": sdk,


  });


return environment;

      }
}