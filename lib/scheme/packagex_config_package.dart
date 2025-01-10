// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class PackagexConfigPackage extends JsonScheme {

  
  PackagexConfigPackage(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"packagexConfigPackage","dart_target":"packagex","flutter_target":"main","dart_name":"packagex","flutter_name":"packagex","output_name":"packagex"};
  }

  /// check data 
  /// if raw data 
  /// - rawData["@type"] == packagexConfigPackage
  /// if same return true
  bool json_scheme_utils_checkDataIsSameBySpecialType() {
    return rawData["@type"] == defaultData["@type"];
  }

  /// check value data whatever do yout want
  bool json_scheme_utils_checkDataIsSameBuilder({
    required bool Function(Map rawData, Map defaultData) onResult,
  }) {
    return onResult(rawData["@type"], defaultData["@type"]);
  }

  

  /// create [PackagexConfigPackage]
  /// Empty  
  static PackagexConfigPackage empty() {
    return PackagexConfigPackage({});
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

  
  set special_type(String? value) {
    rawData["@type"] = value;
  }


  
  String? get dart_target {
    try {
      if (rawData["dart_target"] is String == false){
        return null;
      }
      return rawData["dart_target"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set dart_target(String? value) {
    rawData["dart_target"] = value;
  }


  
  String? get flutter_target {
    try {
      if (rawData["flutter_target"] is String == false){
        return null;
      }
      return rawData["flutter_target"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set flutter_target(String? value) {
    rawData["flutter_target"] = value;
  }


  
  String? get dart_name {
    try {
      if (rawData["dart_name"] is String == false){
        return null;
      }
      return rawData["dart_name"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set dart_name(String? value) {
    rawData["dart_name"] = value;
  }


  
  String? get flutter_name {
    try {
      if (rawData["flutter_name"] is String == false){
        return null;
      }
      return rawData["flutter_name"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set flutter_name(String? value) {
    rawData["flutter_name"] = value;
  }


  
  String? get output_name {
    try {
      if (rawData["output_name"] is String == false){
        return null;
      }
      return rawData["output_name"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set output_name(String? value) {
    rawData["output_name"] = value;
  }


  
  static PackagexConfigPackage create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "packagexConfigPackage",
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
    String? output_name,
})  {
    // PackagexConfigPackage packagexConfigPackage = PackagexConfigPackage({
final Map packagexConfigPackage_data_create_json = {
  
      "@type": special_type,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
      "output_name": output_name,


};


          packagexConfigPackage_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexConfigPackage_data_create_json.containsKey(key) == false) {
          packagexConfigPackage_data_create_json[key] = value;
        }
      });
    }
return PackagexConfigPackage(packagexConfigPackage_data_create_json);


      }
}