// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class FlutterCommands extends JsonScheme {

  
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

    String special_type = "flutter_commands",
    bool? obfuscate,
    String? split_debug_info,
})  {
    // FlutterCommands flutterCommands = FlutterCommands({
Map flutterCommands_data_create_json = {
  
      "@type": special_type,
      "obfuscate": obfuscate,
      "split_debug_info": split_debug_info,


};


          flutterCommands_data_create_json.removeWhere((key, value) => value == null);
FlutterCommands flutterCommands_data_create = FlutterCommands(flutterCommands_data_create_json);

return flutterCommands_data_create;



      }
}