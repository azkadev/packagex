// ignore_for_file: non_constant_identifier_names

import 'package:general_lib/general_lib.dart';
import 'package:packagex/scheme/scheme.dart';

/// UncompleteDocumentation
extension PackagexConfigExtensionOnListString on List<String> {
  /// UncompleteDocumentation
  PackagexConfig packagex_utils_extension_toPackagexConfig() {
    PackagexConfig packagexConfig = PackagexConfig({});
    Args args = Args(this);
    // packagexConfig.dart_target = (args.after("--dart_target") ?? "").trim();
    // packagexConfig.dart_name = (args.after("--dart_name") ?? "").trim();
    // packagexConfig.flutter_target = (args.after("--flutter_target") ?? "").trim();
    // packagexConfig.flutter_name = (args.after("--flutter_name") ?? "").trim();
    if (args.contains("--is_without_platform_name")) {
      packagexConfig.is_without_platform_name = true;
    }
    if (packagexConfig["flutter_commands"] is Map == false) {
      packagexConfig["flutter_commands"] = {};
    }

    return packagexConfig;
  }
}
