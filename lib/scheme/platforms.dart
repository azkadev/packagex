// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class Platforms extends JsonDart {

  
  Platforms(super.rawData);
   
  static Map get defaultData {
    return {"@type":"platforms","android":null,"ios":null,"linux":null,"macos":null,"web":null,"windows":null};
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


  
  Object? get android {
    try {
      if (rawData["android"] is Object == false){
        return null;
      }
      return rawData["android"] as Object;
    } catch (e) {
      return null;
    }
  }


  
  Object? get ios {
    try {
      if (rawData["ios"] is Object == false){
        return null;
      }
      return rawData["ios"] as Object;
    } catch (e) {
      return null;
    }
  }


  
  Object? get linux {
    try {
      if (rawData["linux"] is Object == false){
        return null;
      }
      return rawData["linux"] as Object;
    } catch (e) {
      return null;
    }
  }


  
  Object? get macos {
    try {
      if (rawData["macos"] is Object == false){
        return null;
      }
      return rawData["macos"] as Object;
    } catch (e) {
      return null;
    }
  }


  
  Object? get web {
    try {
      if (rawData["web"] is Object == false){
        return null;
      }
      return rawData["web"] as Object;
    } catch (e) {
      return null;
    }
  }


  
  Object? get windows {
    try {
      if (rawData["windows"] is Object == false){
        return null;
      }
      return rawData["windows"] as Object;
    } catch (e) {
      return null;
    }
  }


  
  static Platforms create({

    String? special_type,
    Object? android,
    Object? ios,
    Object? linux,
    Object? macos,
    Object? web,
    Object? windows,
})  {
    Platforms platforms = Platforms({
  
      "@type": special_type,
      "android": android,
      "ios": ios,
      "linux": linux,
      "macos": macos,
      "web": web,
      "windows": windows,


  });


return platforms;

      }
}