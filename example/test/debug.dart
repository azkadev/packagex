import "dart:io";

import "package:packagex/packagex.dart";
import "package:packagex/api/api.dart" as packagex_api;

void main() async {
  Packagex packagex = Packagex();
  packagex_api.BuildPackage buildPackage = packagex_api.BuildPackage.create(
    special_type: "buildPackage",
    path_current: Directory.current.path,
    platform: "current",
  );
  var res_api = await packagex.request(jsonData: buildPackage.rawData);
  print(res_api);
}
