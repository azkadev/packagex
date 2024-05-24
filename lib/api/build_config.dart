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
// ignore_for_file: non_constant_identifier_names,
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class BuildConfig extends JsonScheme {
  BuildConfig(super.rawData);

  static Map get defaultData {
    return {
      "@type": "buildConfig",
      "name": "Pack",
      "dart_target": "",
      "flutter_target": "",
      "dart_name": "",
      "flutter_name": ""
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

  String? get name {
    try {
      if (rawData["name"] is String == false) {
        return null;
      }
      return rawData["name"] as String;
    } catch (e) {
      return null;
    }
  }

  set name(String? value) {
    rawData["name"] = value;
  }

  String? get dart_target {
    try {
      if (rawData["dart_target"] is String == false) {
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
      if (rawData["flutter_target"] is String == false) {
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
      if (rawData["dart_name"] is String == false) {
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
      if (rawData["flutter_name"] is String == false) {
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

  static BuildConfig create({
    String special_type = "buildConfig",
    String? name,
    String? dart_target,
    String? flutter_target,
    String? dart_name,
    String? flutter_name,
  }) {
    // BuildConfig buildConfig = BuildConfig({
    Map buildConfig_data_create_json = {
      "@type": special_type,
      "name": name,
      "dart_target": dart_target,
      "flutter_target": flutter_target,
      "dart_name": dart_name,
      "flutter_name": flutter_name,
    };

    buildConfig_data_create_json.removeWhere((key, value) => value == null);
    BuildConfig buildConfig_data_create =
        BuildConfig(buildConfig_data_create_json);

    return buildConfig_data_create;
  }
}
