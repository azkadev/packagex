import 'dart:io';

import 'package:example/packagex/packagex.dart';

void main(List<String> args) {
  print(PackagexProjectExample.isSame(data: File("/home/galaxeus/Documents/galaxeus/app/packagex/example/build/packagex/example.json").readAsStringSync()));
}
