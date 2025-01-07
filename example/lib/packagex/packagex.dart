// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class PackagexProjectExample {

  static bool isSame({
    required String data
  }) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }

    static String get default_data_to_string {
      return (JsonEncoder.withIndent(" " * 2).convert(default_data));
    }

    static Map get default_data {
return {
  "name": "example",
  "description": "A new Flutter project.",
  "publish_to": "none",
  "version": "1.0.0+1",
  "obfuscate": true,
  "split-debug-info": "0.0.0",
  "build-name": "0.0.0",
  "build-number": 1,
  "split-per-abi": true,
  "no-tree-shake-icons": true
};
    }

}