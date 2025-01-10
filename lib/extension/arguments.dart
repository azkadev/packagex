import 'package:general_lib/general_lib.dart';

extension ListStringExtensionArguments on List<String> {
  List<String> packagexUtilsParseFlutterArgumentsAndroid() {
    final List<String> datas = clone(); 
    return datas;
  }

  List<String> packagexUtilsParseFlutterArgumentsIos() {
    final List<String> datas = clone();

    datas.remove("--split-per-abi");
    return datas;
  }

  List<String> packagexUtilsParseFlutterArgumentsLinux() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    return datas;
  }

  List<String> packagexUtilsParseFlutterArgumentsMacos() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    return datas;
  }

  List<String> packagexUtilsParseFlutterArgumentsWindows() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    return datas;
  }

  List<String> packagexUtilsParseFlutterArgumentsWeb() {
    final List<String> datas = clone();
    datas.remove("--split-per-abi");
    return datas;
  }
}
