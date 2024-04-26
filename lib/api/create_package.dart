// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class CreatePackage extends JsonScheme {

  
  CreatePackage(super.rawData);
   
  static Map get defaultData {
    return {"@type":"createPackage","path":""};
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

    String special_type = "createPackage",
    String? path,
})  {
    // CreatePackage createPackage = CreatePackage({
Map createPackage_data_create_json = {
  
      "@type": special_type,
      "path": path,


};


          createPackage_data_create_json.removeWhere((key, value) => value == null);
CreatePackage createPackage_data_create = CreatePackage(createPackage_data_create_json);

return createPackage_data_create;



      }
}