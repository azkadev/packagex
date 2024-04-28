// ignore_for_file: non_constant_identifier_names

import 'package:general_lib/general_lib.dart';

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
}
