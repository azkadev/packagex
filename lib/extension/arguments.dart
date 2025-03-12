import 'package:general_lib/general_lib.dart';

/// UncompleteDocumentation
extension ListStringExtensionArguments on List<String> {
  /// UncompleteDocumentation
  List<String> packagexUtilsParseFlutterArgumentsAndroid() {
    final List<String> datas = clone();
    datas.remove("--wasm");
    return datas;
  }

  /// UncompleteDocumentation
  List<String> packagexUtilsParseFlutterArgumentsIos() {
    final List<String> datas = clone();

    datas.remove("--split-per-abi");
    datas.remove("--wasm");
    return datas;
  }

  /// UncompleteDocumentation

  List<String> packagexUtilsParseFlutterArgumentsLinux() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    datas.remove("--wasm");
    return datas;
  }

  /// UncompleteDocumentation
  List<String> packagexUtilsParseFlutterArgumentsMacos() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    datas.remove("--wasm");
    return datas;
  }

  /// UncompleteDocumentation

  List<String> packagexUtilsParseFlutterArgumentsWindows() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    datas.remove("--wasm");
    return datas;
  }

  /// UncompleteDocumentation

  List<String> packagexUtilsParseFlutterArgumentsWeb() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    datas.remove("--obfuscate");
    Args args = Args(datas);
    final String splitDebugInfo = args.after(["--split-debug-info"]) ?? "";
    if (splitDebugInfo.isNotEmpty) {
      datas.remove(splitDebugInfo);
    }
    datas.remove("--split-debug-info");
    return datas;
  }
}
