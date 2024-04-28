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
// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:general_lib/general_lib.dart';
import 'package:packagex/packagex_core.dart';

extension StringPackagexExtensionOnNull on String? {
  String packagex_utils_extension_toLinuxProgram() {
    return (this ?? "").packagex_utils_extension_toLinuxProgram();
  }
}

extension StringPackagexExtensionOn on String {
  String packagex_utils_extension_toLinuxProgram() {
    String text = this;
    List<RegExpReplace> regExpReplaces = [
      RegExpReplace(
        from: RegExp("([._]+)"),
        replace: (match) {
          return "-";
        },
      ),
    ];
    for (var i = 0; i < regExpReplaces.length; i++) {
      RegExpReplace regExpReplace = regExpReplaces[i];

      text = text.replaceAllMapped(regExpReplace.from, regExpReplace.replace);
    }

    return text;
  }

  List<PackagexPlatformType> toPackagexPlatformTypes({
    bool isAutoPlatformCurrent = true,
  }) {
    List<String> texts = split(",");
    List<PackagexPlatformType> packagexPlatformTypes = [];
    for (String text in texts) {
      PackagexPlatformType? packagexPlatformType = PackagexPlatformType.values
          .firstWhereOrNull((element) =>
              element.name.toLowerCase() == text.toLowerCase().trim());
      if (packagexPlatformType != null) {
        if (!packagexPlatformTypes.contains(packagexPlatformType)) {
          packagexPlatformTypes.add(packagexPlatformType);
        }
      }
    }
    if (packagexPlatformTypes.isEmpty) {
      if (Dart.isAndroid) {
        packagexPlatformTypes.add(PackagexPlatformType.android);
      }
      if (Dart.isIOS) {
        packagexPlatformTypes.add(PackagexPlatformType.ios);
      }
      if (Dart.isLinux) {
        packagexPlatformTypes.add(PackagexPlatformType.linux);
      }
      if (Dart.isMacOS) {
        packagexPlatformTypes.add(PackagexPlatformType.macos);
      }
      if (Dart.isWeb) {
        packagexPlatformTypes.add(PackagexPlatformType.web);
      }
      if (Dart.isWindows) {
        packagexPlatformTypes.add(PackagexPlatformType.windows);
      }
    }
    return packagexPlatformTypes.toSet().toList();
  }
}
