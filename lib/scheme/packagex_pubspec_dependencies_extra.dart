// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


/// Generated 
class PackagexPubspecDependenciesExtra extends JsonScheme {

  /// Generated
  PackagexPubspecDependenciesExtra(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"packagexPubspecDependenciesExtra","sdk":"flutter"};
  }

  /// check data 
  /// if raw data 
  /// - rawData["@type"] == packagexPubspecDependenciesExtra
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

  

  /// create [PackagexPubspecDependenciesExtra]
  /// Empty  
  static PackagexPubspecDependenciesExtra empty() {
    return PackagexPubspecDependenciesExtra({});
  }

  

  /// Generated
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

  /// Generated
  set special_type(String? value) {
    rawData["@type"] = value;
  }


  /// Generated
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

  /// Generated
  set sdk(String? value) {
    rawData["sdk"] = value;
  }


  /// Generated
  static PackagexPubspecDependenciesExtra create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "packagexPubspecDependenciesExtra",
    String? sdk,
})  {
    // PackagexPubspecDependenciesExtra packagexPubspecDependenciesExtra = PackagexPubspecDependenciesExtra({
final Map packagexPubspecDependenciesExtra_data_create_json = {
  
      "@type": special_type,
      "sdk": sdk,


};


          packagexPubspecDependenciesExtra_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexPubspecDependenciesExtra_data_create_json.containsKey(key) == false) {
          packagexPubspecDependenciesExtra_data_create_json[key] = value;
        }
      });
    }
return PackagexPubspecDependenciesExtra(packagexPubspecDependenciesExtra_data_create_json);


      }
}