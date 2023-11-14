import "package:general_lib/general_lib.dart";
import "package:universal_io/io.dart";

Future<void> main() async {
  List<Map> datas = [
    {
      "@type": "error",
      "description": "",
      "message": "",
    },
    {
      "@type": "createPackage",
      "path": "",
    },
    {
      "@type": "buildPackage",
      "platform": "",
      "path_current": "",
      "path_output": "",
      "build_config": {
        "@type": "buildConfig",
        "name": "Pack",
        "dart_target": "",
        "flutter_target": "",
        "dart_name": "",
        "flutter_name": "",
      },
    },
  ];

  await jsonToScripts(
    datas,
    directory: Directory(
      "lib/api",
    ),
  );
}
