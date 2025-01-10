// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class PackagexConfigUploadTelegramChat extends JsonScheme {

  
  PackagexConfigUploadTelegramChat(super.rawData);
  
  /// return default data
  /// 
  static Map get defaultData {
    return {"@type":"packagexConfigUploadTelegramChat","chat_id":"","message_thread_id":""};
  }

  /// check data 
  /// if raw data 
  /// - rawData["@type"] == packagexConfigUploadTelegramChat
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

  

  /// create [PackagexConfigUploadTelegramChat]
  /// Empty  
  static PackagexConfigUploadTelegramChat empty() {
    return PackagexConfigUploadTelegramChat({});
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


  
  String? get chat_id {
    try {
      if (rawData["chat_id"] is String == false){
        return null;
      }
      return rawData["chat_id"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set chat_id(String? value) {
    rawData["chat_id"] = value;
  }


  
  String? get message_thread_id {
    try {
      if (rawData["message_thread_id"] is String == false){
        return null;
      }
      return rawData["message_thread_id"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set message_thread_id(String? value) {
    rawData["message_thread_id"] = value;
  }


  
  static PackagexConfigUploadTelegramChat create({
              bool schemeUtilsIsSetDefaultData = false,

    String special_type = "packagexConfigUploadTelegramChat",
    String? chat_id,
    String? message_thread_id,
})  {
    // PackagexConfigUploadTelegramChat packagexConfigUploadTelegramChat = PackagexConfigUploadTelegramChat({
final Map packagexConfigUploadTelegramChat_data_create_json = {
  
      "@type": special_type,
      "chat_id": chat_id,
      "message_thread_id": message_thread_id,


};


          packagexConfigUploadTelegramChat_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (packagexConfigUploadTelegramChat_data_create_json.containsKey(key) == false) {
          packagexConfigUploadTelegramChat_data_create_json[key] = value;
        }
      });
    }
return PackagexConfigUploadTelegramChat(packagexConfigUploadTelegramChat_data_create_json);


      }
}