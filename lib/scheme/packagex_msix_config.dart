/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class PackagexMsixConfig extends JsonScheme {
  PackagexMsixConfig(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexMsixConfig",
      "display_name": "example",
      "publisher_display_name": "Azkadev Packagex",
      "identity_name": "org.azkadev.example",
      "msix_version": "0.0.0.0",
      "logo_path": "example/bin/example.dart",
      "capabilities": "internetClient, location, microphone, webcam",
      "install_certificate": false
    };
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
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

  String? get display_name {
    try {
      if (rawData["display_name"] is String == false) {
        return null;
      }
      return rawData["display_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set display_name(String? value) {
    rawData["display_name"] = value;
  }

  String? get publisher_display_name {
    try {
      if (rawData["publisher_display_name"] is String == false) {
        return null;
      }
      return rawData["publisher_display_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set publisher_display_name(String? value) {
    rawData["publisher_display_name"] = value;
  }

  String? get identity_name {
    try {
      if (rawData["identity_name"] is String == false) {
        return null;
      }
      return rawData["identity_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set identity_name(String? value) {
    rawData["identity_name"] = value;
  }

  String? get msix_version {
    try {
      if (rawData["msix_version"] is String == false) {
        return null;
      }
      return rawData["msix_version"] as String;
    } catch (e) {
      return null;
    }
  }

  set msix_version(String? value) {
    rawData["msix_version"] = value;
  }

  String? get logo_path {
    try {
      if (rawData["logo_path"] is String == false) {
        return null;
      }
      return rawData["logo_path"] as String;
    } catch (e) {
      return null;
    }
  }

  set logo_path(String? value) {
    rawData["logo_path"] = value;
  }

  String? get capabilities {
    try {
      if (rawData["capabilities"] is String == false) {
        return null;
      }
      return rawData["capabilities"] as String;
    } catch (e) {
      return null;
    }
  }

  set capabilities(String? value) {
    rawData["capabilities"] = value;
  }

  bool? get install_certificate {
    try {
      if (rawData["install_certificate"] is bool == false) {
        return null;
      }
      return rawData["install_certificate"] as bool;
    } catch (e) {
      return null;
    }
  }

  set install_certificate(bool? value) {
    rawData["install_certificate"] = value;
  }

  static PackagexMsixConfig create({
    String special_type = "packagexMsixConfig",
    String? display_name,
    String? publisher_display_name,
    String? identity_name,
    String? msix_version,
    String? logo_path,
    String? capabilities,
    bool? install_certificate,
  }) {
    // PackagexMsixConfig packagexMsixConfig = PackagexMsixConfig({
    Map packagexMsixConfig_data_create_json = {
      "@type": special_type,
      "display_name": display_name,
      "publisher_display_name": publisher_display_name,
      "identity_name": identity_name,
      "msix_version": msix_version,
      "logo_path": logo_path,
      "capabilities": capabilities,
      "install_certificate": install_certificate,
    };

    packagexMsixConfig_data_create_json
        .removeWhere((key, value) => value == null);
    PackagexMsixConfig packagexMsixConfig_data_create =
        PackagexMsixConfig(packagexMsixConfig_data_create_json);

    return packagexMsixConfig_data_create;
  }
}
