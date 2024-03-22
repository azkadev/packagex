// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class FlutterCommands extends JsonScheme {

  
  FlutterCommands(super.rawData);
   
  static Map get defaultData {
    return {"@type":"flutter_commands","obfuscate":true,"split-debug-info":"0.0.5","build-name":"0.0.5","build-number":40,"split-per-abi":true,"no-tree-shake-icons":true};
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
      if (rawData["split-debug-info"] is String == false){
        return null;
      }
      return rawData["split-debug-info"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get build_name {
    try {
      if (rawData["build-name"] is String == false){
        return null;
      }
      return rawData["build-name"] as String;
    } catch (e) {
      return null;
    }
  }


  
  num? get build_number {
    try {
      if (rawData["build-number"] is num == false){
        return null;
      }
      return rawData["build-number"] as num;
    } catch (e) {
      return null;
    }
  }


  
  bool? get split_per_abi {
    try {
      if (rawData["split-per-abi"] is bool == false){
        return null;
      }
      return rawData["split-per-abi"] as bool;
    } catch (e) {
      return null;
    }
  }


  
  bool? get no_tree_shake_icons {
    try {
      if (rawData["no-tree-shake-icons"] is bool == false){
        return null;
      }
      return rawData["no-tree-shake-icons"] as bool;
    } catch (e) {
      return null;
    }
  }


  
  static FlutterCommands create({

    String special_type = "flutter_commands",
    bool? obfuscate,
    String? split_debug_info,
    String? build_name,
    num? build_number,
    bool? split_per_abi,
    bool? no_tree_shake_icons,
})  {
    // FlutterCommands flutterCommands = FlutterCommands({
Map flutterCommands_data_create_json = {
  
      "@type": special_type,
      "obfuscate": obfuscate,
      "split-debug-info": split_debug_info,
      "build-name": build_name,
      "build-number": build_number,
      "split-per-abi": split_per_abi,
      "no-tree-shake-icons": no_tree_shake_icons,


};


          flutterCommands_data_create_json.removeWhere((key, value) => value == null);
FlutterCommands flutterCommands_data_create = FlutterCommands(flutterCommands_data_create_json);

return flutterCommands_data_create;



      }
}