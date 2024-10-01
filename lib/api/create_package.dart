// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class CreatePackage extends JsonScheme {

  
  CreatePackage(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"createPackage","path":""};
  }

  /// check data 
  /// if raw data 
  /// - rawData["@type"] == createPackage
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

  

  /// create [CreatePackage]
  /// Empty  
  static CreatePackage empty() {
    return CreatePackage({});
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

  
  set path(String? value) {
    rawData["path"] = value;
  }


  
  static CreatePackage create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "createPackage",
    String? path,
})  {
    // CreatePackage createPackage = CreatePackage({
final Map createPackage_data_create_json = {
  
      "@type": special_type,
      "path": path,


};


          createPackage_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (createPackage_data_create_json.containsKey(key) == false) {
          createPackage_data_create_json[key] = value;
        }
      });
    }
return CreatePackage(createPackage_data_create_json);


      }
}