// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class Packagex extends JsonDart {

  
  Packagex(super.rawData);
   
  static Map get defaultData {
    return {"@type":"packagex","command":""};
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


  
  String? get command {
    try {
      if (rawData["command"] is String == false){
        return null;
      }
      return rawData["command"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static Packagex create({

    String? special_type,
    String? command,
})  {
    Packagex packagex = Packagex({
  
      "@type": special_type,
      "command": command,


  });


return packagex;

      }
}