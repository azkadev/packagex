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

import "packagex_pubspec_dev_dependencies_extra.dart";

class PackagexPubspecDevDependencies extends JsonScheme {
  PackagexPubspecDevDependencies(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexPubspecDevDependencies",
      "lints": "^2.0.0",
      "test": "^1.16.0",
      "packagex": {
        "@type": "packagexPubspecDevDependenciesExtra",
        "path": "../"
      },
      "msix": "^1.0.6"
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

  String? get lints {
    try {
      if (rawData["lints"] is String == false) {
        return null;
      }
      return rawData["lints"] as String;
    } catch (e) {
      return null;
    }
  }

  set lints(String? value) {
    rawData["lints"] = value;
  }

  String? get test {
    try {
      if (rawData["test"] is String == false) {
        return null;
      }
      return rawData["test"] as String;
    } catch (e) {
      return null;
    }
  }

  set test(String? value) {
    rawData["test"] = value;
  }

  PackagexPubspecDevDependenciesExtra get packagex {
    try {
      if (rawData["packagex"] is Map == false) {
        return PackagexPubspecDevDependenciesExtra({});
      }
      return PackagexPubspecDevDependenciesExtra(rawData["packagex"] as Map);
    } catch (e) {
      return PackagexPubspecDevDependenciesExtra({});
    }
  }

  set packagex(PackagexPubspecDevDependenciesExtra value) {
    rawData["packagex"] = value.toJson();
  }

  String? get msix {
    try {
      if (rawData["msix"] is String == false) {
        return null;
      }
      return rawData["msix"] as String;
    } catch (e) {
      return null;
    }
  }

  set msix(String? value) {
    rawData["msix"] = value;
  }

  static PackagexPubspecDevDependencies create({
    String special_type = "packagexPubspecDevDependencies",
    String? lints,
    String? test,
    PackagexPubspecDevDependenciesExtra? packagex,
    String? msix,
  }) {
    // PackagexPubspecDevDependencies packagexPubspecDevDependencies = PackagexPubspecDevDependencies({
    Map packagexPubspecDevDependencies_data_create_json = {
      "@type": special_type,
      "lints": lints,
      "test": test,
      "packagex": (packagex != null) ? packagex.toJson() : null,
      "msix": msix,
    };

    packagexPubspecDevDependencies_data_create_json
        .removeWhere((key, value) => value == null);
    PackagexPubspecDevDependencies packagexPubspecDevDependencies_data_create =
        PackagexPubspecDevDependencies(
            packagexPubspecDevDependencies_data_create_json);

    return packagexPubspecDevDependencies_data_create;
  }
}
