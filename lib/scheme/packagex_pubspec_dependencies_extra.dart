// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class PackagexPubspecDependenciesExtra extends JsonScheme {

  
  PackagexPubspecDependenciesExtra(super.rawData);
   
  static Map get defaultData {
    return {"@type":"packagexPubspecDependenciesExtra","sdk":"flutter"};
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

  
  set sdk(String? value) {
    rawData["sdk"] = value;
  }


  
  static PackagexPubspecDependenciesExtra create({

    String special_type = "packagexPubspecDependenciesExtra",
    String? sdk,
})  {
    // PackagexPubspecDependenciesExtra packagexPubspecDependenciesExtra = PackagexPubspecDependenciesExtra({
Map packagexPubspecDependenciesExtra_data_create_json = {
  
      "@type": special_type,
      "sdk": sdk,


};


          packagexPubspecDependenciesExtra_data_create_json.removeWhere((key, value) => value == null);
PackagexPubspecDependenciesExtra packagexPubspecDependenciesExtra_data_create = PackagexPubspecDependenciesExtra(packagexPubspecDependenciesExtra_data_create_json);

return packagexPubspecDependenciesExtra_data_create;



      }
}