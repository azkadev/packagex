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
import "package:general_lib/general_lib.dart";
import "package:io_universe/io_universe.dart";

Future<void> main() async {
  List<Map> datas = [
    {
      "@type": "packagexPubspec",
      "name": "example",
      "description": "A sample command-line application.",
      "version": "0.0.0",
      "publish_to": "none",
      "homepage": "https://youtube.com/@azkadev",
      "repository": "https://github.com/azkadev/packagex.git",
      "platforms": {
        "@type": "packagexPubspecPlatforms",
        "android": null,
        "ios": null,
        "linux": null,
        "macos": null,
        "web": null,
        "windows": null,
      },
      "environment": {
        "@type": "packagexPubspecEnvironment",
        "sdk": ">=2.18.5 <3.0.0",
      },
      "dependencies": {
        "@type": "packagexPubspecDependencies",
        "flutter": {
          "@type": "packagexPubspecDependenciesExtra",
          "sdk": "flutter",
        },
        "cupertino_icons": "^1.0.2"
      },
      "dev_dependencies": {
        "@type": "packagexPubspecDevDependencies",
        "lints": "^2.0.0",
        "test": "^1.16.0",
        "packagex": {
          "@type": "packagexPubspecDevDependenciesExtra",
          "path": "../",
        },
        "msix": "^1.0.6"
      },
      "packagex": {
        "@type": "packagexConfig",
        "name": "Pack",
        "is_without_platform_name": true,
        "is_app_auto_clean_up_folder": false,
        "flutter_commands": {
          "@type": "packagexConfigFlutterCommands",
          "obfuscate": true,
          "split-debug-info": "0.0.5",
          "build-name": "0.0.5",
          "build-number": 40,
          "split-per-abi": true,
          "no-tree-shake-icons": true,
        }, 
        "uploads": [
          {
            "@type": "packagexConfigUpload",
            "platform_type": "",
            "github_username": "",
            "github_tag": "",
            "github_is_org": false,
            "github_repository_name": "",
            "supabase_folder_name": "",
            "telegram_chat_id": "",
          },
        ],
        "packages": [
          {
            "@type": "packagexConfigPackage",
            "dart_target": "packagex",
            "flutter_target": "main",
            "dart_name": "packagex",
            "flutter_name": "packagex",
            "output_name": "packagex",
          },
        ],
      },
      "msix_config": {
        "@type": "packagexMsixConfig",
        "display_name": "example",
        "publisher_display_name": "Azkadev Packagex",
        "identity_name": "org.azkadev.example",
        "msix_version": "0.0.0.0",
        "logo_path": "example/bin/example.dart",
        "capabilities": "internetClient, location, microphone, webcam",
        "install_certificate": false,
      },
    }
  ];
  Directory(
    "lib/scheme",
  ).deleteSync(recursive: true);
  await jsonToScripts(
    datas,
    directory: Directory(
      "lib/scheme",
    ),
  );
}
