// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_pubspec_dependencies_extra.dart";

 
class PackagexPubspecDependencies extends JsonScheme {

  
  PackagexPubspecDependencies(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"packagexPubspecDependencies","flutter":{"@type":"packagexPubspecDependenciesExtra","sdk":"flutter"},"cupertino_icons":"^1.0.2"};
  }

  /// check data 
  /// if raw data 
  /// - rawData["@type"] == packagexPubspecDependencies
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

  

  /// create [PackagexPubspecDependencies]
  /// Empty  
  static PackagexPubspecDependencies empty() {
    return PackagexPubspecDependencies({});
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


  
  PackagexPubspecDependenciesExtra get flutter {
    try {
      if (rawData["flutter"] is Map == false){
        return PackagexPubspecDependenciesExtra({}); 
      }
      return PackagexPubspecDependenciesExtra(rawData["flutter"] as Map);
    } catch (e) {  
      return PackagexPubspecDependenciesExtra({}); 
    }
  }


  
  set flutter(PackagexPubspecDependenciesExtra value) {
    rawData["flutter"] = value.toJson();
  }



  
  String? get cupertino_icons {
    try {
      if (rawData["cupertino_icons"] is String == false){
        return null;
      }
      return rawData["cupertino_icons"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set cupertino_icons(String? value) {
    rawData["cupertino_icons"] = value;
  }


  
  static PackagexPubspecDependencies create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "packagexPubspecDependencies",
      PackagexPubspecDependenciesExtra? flutter,
    String? cupertino_icons,
})  {
    // PackagexPubspecDependencies packagexPubspecDependencies = PackagexPubspecDependencies({
final Map packagexPubspecDependencies_data_create_json = {
  
      "@type": special_type,
      "flutter": (flutter != null)?flutter.toJson(): null,
      "cupertino_icons": cupertino_icons,


};


          packagexPubspecDependencies_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexPubspecDependencies_data_create_json.containsKey(key) == false) {
          packagexPubspecDependencies_data_create_json[key] = value;
        }
      });
    }
return PackagexPubspecDependencies(packagexPubspecDependencies_data_create_json);


      }
}