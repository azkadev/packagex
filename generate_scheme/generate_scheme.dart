import "package:general_lib/general_lib.dart";
import "package:universal_io/io.dart";

Future<void> main() async {
  List<Map> datas = [
    {
      "@type": "pubspec",
      "name": "example",
      "description": "A sample command-line application.",
      "version": "0.0.0",
      "publish_to": "none",
      "homepage": "https://youtube.com/@azkadev",
      "repository": "https://github.com/azkadev/packagex.git",
      "platforms": {
        "@type": "platforms",
        "android": null,
        "ios": null,
        "linux": null,
        "macos": null,
        "web": null,
        "windows": null,
      },
      "environment": {
        "@type": "environment",
        "sdk": ">=2.18.5 <3.0.0",
      },
      "dependencies": {
        "@type": "dependencies",
        "flutter": {
          "@type": "dependencies_extra",
          "sdk": "flutter",
        },
        "cupertino_icons": "^1.0.2"
      },
      "dev_dependencies": {
        "@type": "dev_dependencies",
        "lints": "^2.0.0",
        "test": "^1.16.0",
        "packagex": {
          "@type": "dev_dependencies_extra",
          "path": "../",
        },
        "msix": "^1.0.6"
      },
      "packagex": {
        "@type": "packagex",
        "name": "Pack",
        "dart_target": "",
        "flutter_target": "",
        "dart_name": "",
        "flutter_name": "",
        "is_without_platform_name": true,
        "flutter_commands": {
          "@type": "flutter_commands",
          "obfuscate": true, 
          "split-debug-info": "0.0.5",
          "build-name": "0.0.5",
          "build-number": 40,
          "split-per-abi": true,
          "no-tree-shake-icons": true,
        },
        "project_id": "",
        "github_username": "",
        "github_is_org": true,
      },
      "msix_config": {
        "@type": "msix_config",
        "display_name": "example",
        "publisher_display_name": "Azkadev Packagex",
        "identity_name": "org.azkadev.example",
        "msix_version": "0.0.0.0",
        "logo_path": "example/bin/example.dart",
        "capabilities": "internetClient, location, microphone, webcam",
      },
    }
  ];

  await jsonToScripts(
    datas,
    directory: Directory(
      "lib/scheme",
    ),
  );
}
