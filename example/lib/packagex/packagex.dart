// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class PackagexProjectExample {
  static bool isSame({required String data}) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }

  static String get default_data_to_string {
    return (JsonEncoder.withIndent(" " * 2).convert(default_data));
  }

  static Map get default_data {
    return {
      "name": "example",
      "description": "A sample command-line application.",
      "version": "0.0.0",
      "publish_to": "none",
      "dependency_overrides": {"pointycastle": "3.8.0", "mime": "^2.0.0"},
      "funding": [
        "https://github.com/sponsors/azkadev",
        "https://github.com/sponsors/generalfoss"
      ],
      "homepage": "https://youtube.com/@azkadev",
      "repository": "https://github.com/azkadev/general_framework",
      "issue_tracker": "https://t.me/DEVELOPER_GLOBAL_PUBLIC",
      "documentation": "https://youtube.com/@azkadev",
      "obfuscate": true,
      "split-debug-info": "0.0.0",
      "build-name": "0.0.0",
      "build-number": 1,
      "split-per-abi": true,
      "no-tree-shake-icons": true
    };
  }
}
