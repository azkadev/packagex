// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

/// AutoGenerateBy Packagex
class PackagexProjectExample {
  /// AutoGenerateBy Packagex
  static bool isSame({required String data}) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }

  /// AutoGenerateBy Packagex
  static String get default_data_to_string {
    return (JsonEncoder.withIndent(" " * 2).convert(default_data));
  }

  /// AutoGenerateBy Packagex
  static Map get default_data {
    return {
      "name": "example",
      "description": "A new Flutter project.",
      "publish_to": "none",
      "version": "1.0.0+1",
      "funding": []
    };
  }
}
