// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class FlutterCommands extends JsonDart {

  
  FlutterCommands(super.rawData);
   
  static Map get defaultData {
    return {"@type":"flutter_commands","obfuscate":true,"split_debug_info":"0.0.5"};
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


  
  bool? get obfuscate {
    try {
      if (rawData["obfuscate"] is bool == false){
        return null;
      }
      return rawData["obfuscate"] as bool;
    } catch (e) {
      return null;
    }
  }


  
  String? get split_debug_info {
    try {
      if (rawData["split_debug_info"] is String == false){
        return null;
      }
      return rawData["split_debug_info"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static FlutterCommands create({

    String? special_type,
    bool? obfuscate,
    String? split_debug_info,
})  {
    FlutterCommands flutterCommands = FlutterCommands({
  
      "@type": special_type,
      "obfuscate": obfuscate,
      "split_debug_info": split_debug_info,


  });


return flutterCommands;

      }
}