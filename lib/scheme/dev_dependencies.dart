// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "dev_dependencies_extra.dart";

 
class DevDependencies extends JsonScheme {

  
  DevDependencies(super.rawData);
   
  static Map get defaultData {
    return {"@type":"dev_dependencies","lints":"^2.0.0","test":"^1.16.0","packagex":{"@type":"dev_dependencies_extra","path":"../"},"msix":"^1.0.6"};
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


  
  String? get lints {
    try {
      if (rawData["lints"] is String == false){
        return null;
      }
      return rawData["lints"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get test {
    try {
      if (rawData["test"] is String == false){
        return null;
      }
      return rawData["test"] as String;
    } catch (e) {
      return null;
    }
  }


  
  DevDependenciesExtra get packagex {
    try {
      if (rawData["packagex"] is Map == false){
        return DevDependenciesExtra({}); 
      }
      return DevDependenciesExtra(rawData["packagex"] as Map);
    } catch (e) {  
      return DevDependenciesExtra({}); 
    }
  }


  
  String? get msix {
    try {
      if (rawData["msix"] is String == false){
        return null;
      }
      return rawData["msix"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static DevDependencies create({

    String special_type = "dev_dependencies",
    String? lints,
    String? test,
      DevDependenciesExtra? packagex,
    String? msix,
})  {
    // DevDependencies devDependencies = DevDependencies({
Map devDependencies_data_create_json = {
  
      "@type": special_type,
      "lints": lints,
      "test": test,
      "packagex": (packagex != null)?packagex.toJson(): null,
      "msix": msix,


};


          devDependencies_data_create_json.removeWhere((key, value) => value == null);
DevDependencies devDependencies_data_create = DevDependencies(devDependencies_data_create_json);

return devDependencies_data_create;



      }
}