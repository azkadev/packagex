// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

import "platforms.dart";
import "environment.dart";
import "dependencies.dart";
import "dev_dependencies.dart";
import "packagex.dart";
import "msix_config.dart";


class Pubspec extends JsonDart {

  
  Pubspec(super.rawData);
   
  static Map get defaultData {
    return {"@type":"pubspec","name":"example","description":"A sample command-line application.","version":"0.0.0","publish_to":"none","homepage":"https://youtube.com/@azkadev","repository":"https://github.com/azkadev/packagex.git","platforms":{"@type":"platforms","android":null,"ios":null,"linux":null,"macos":null,"web":null,"windows":null},"environment":{"@type":"environment","sdk":">=2.18.5 <3.0.0"},"dependencies":{"@type":"dependencies","flutter":{"@type":"dependencies_extra","sdk":"flutter"},"cupertino_icons":"^1.0.2"},"dev_dependencies":{"@type":"dev_dependencies","lints":"^2.0.0","test":"^1.16.0","packagex":{"@type":"dev_dependencies_extra","path":"../"},"msix":"^1.0.6"},"packagex":{"@type":"packagex","command":""},"msix_config":{"@type":"msix_config","display_name":"example","publisher_display_name":"Azkadev Packagex","identity_name":"org.azkadev.example","msix_version":"0.0.0.0","logo_path":"example/bin/example.dart","capabilities":"internetClient, location, microphone, webcam"}};
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


  
  String? get name {
    try {
      if (rawData["name"] is String == false){
        return null;
      }
      return rawData["name"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get description {
    try {
      if (rawData["description"] is String == false){
        return null;
      }
      return rawData["description"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get version {
    try {
      if (rawData["version"] is String == false){
        return null;
      }
      return rawData["version"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get publish_to {
    try {
      if (rawData["publish_to"] is String == false){
        return null;
      }
      return rawData["publish_to"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get homepage {
    try {
      if (rawData["homepage"] is String == false){
        return null;
      }
      return rawData["homepage"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get repository {
    try {
      if (rawData["repository"] is String == false){
        return null;
      }
      return rawData["repository"] as String;
    } catch (e) {
      return null;
    }
  }


  
  Platforms get platforms {
    try {
      if (rawData["platforms"] is Map == false){
        return Platforms({}); 
      }
      return Platforms(rawData["platforms"] as Map);
    } catch (e) {  
      return Platforms({}); 
    }
  }


  
  Environment get environment {
    try {
      if (rawData["environment"] is Map == false){
        return Environment({}); 
      }
      return Environment(rawData["environment"] as Map);
    } catch (e) {  
      return Environment({}); 
    }
  }


  
  Dependencies get dependencies {
    try {
      if (rawData["dependencies"] is Map == false){
        return Dependencies({}); 
      }
      return Dependencies(rawData["dependencies"] as Map);
    } catch (e) {  
      return Dependencies({}); 
    }
  }


  
  DevDependencies get dev_dependencies {
    try {
      if (rawData["dev_dependencies"] is Map == false){
        return DevDependencies({}); 
      }
      return DevDependencies(rawData["dev_dependencies"] as Map);
    } catch (e) {  
      return DevDependencies({}); 
    }
  }


  
  Packagex get packagex {
    try {
      if (rawData["packagex"] is Map == false){
        return Packagex({}); 
      }
      return Packagex(rawData["packagex"] as Map);
    } catch (e) {  
      return Packagex({}); 
    }
  }


  
  MsixConfig get msix_config {
    try {
      if (rawData["msix_config"] is Map == false){
        return MsixConfig({}); 
      }
      return MsixConfig(rawData["msix_config"] as Map);
    } catch (e) {  
      return MsixConfig({}); 
    }
  }


  
  static Pubspec create({

    String? special_type,
    String? name,
    String? description,
    String? version,
    String? publish_to,
    String? homepage,
    String? repository,
      Platforms? platforms,
      Environment? environment,
      Dependencies? dependencies,
      DevDependencies? dev_dependencies,
      Packagex? packagex,
      MsixConfig? msix_config,
})  {
    Pubspec pubspec = Pubspec({
  
      "@type": special_type,
      "name": name,
      "description": description,
      "version": version,
      "publish_to": publish_to,
      "homepage": homepage,
      "repository": repository,
      "platforms": (platforms != null)?platforms.toJson(): null,
      "environment": (environment != null)?environment.toJson(): null,
      "dependencies": (dependencies != null)?dependencies.toJson(): null,
      "dev_dependencies": (dev_dependencies != null)?dev_dependencies.toJson(): null,
      "packagex": (packagex != null)?packagex.toJson(): null,
      "msix_config": (msix_config != null)?msix_config.toJson(): null,


  });


return pubspec;

      }
}