import 'dart:io';

import 'package:general_lib/general_lib.dart';

void main(List<String> args) {
  print(Dart.pub.installFromDirectory(directoryPackage: Directory.current));
}
