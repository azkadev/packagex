import 'package:general_lib/general_lib.dart';
import 'package:yaml/yaml.dart' as yaml;

void main(List<String> args) {
  Map yaml_code = (yaml.loadYaml(pubspec_yaml, recover: true) as Map);
  yaml_code.printPretty();
}

final String pubspec_yaml = """

name: "packagex"
description: "A library for package dart or flutter to specific platform."
version: "0.0.70"
homepage: "https://youtube.com/@azkadev"
repository: "https://github.com/azkadev/packagex.git"
platforms:
  android: null
  ios: null
  linux: null
  macos: null
  web: null
  windows: null
environment:
  sdk: ">=3.6.0 <4.0.0"
dev_dependencies:
  lints: "^5.0.0"
  msix: "^3.16.7"
  test: "any"
executables:
  packagex: "packagex"
dependencies:
  collection: "^1.19.0"
  general_lib: "^0.0.56"
  github: "^9.24.0"
  http: "^1.2.2"
  mason_logger: "^0.3.1"
  mime: "^2.0.0"
  path: "^1.9.0"
  io_universe: "^0.0.4"
  yaml: "^3.1.3"
  yaml_writer: "^2.0.1"
  system_information: "^0.0.9"
packagex:
  name: "packagex"
  flutter_commands:
    obfuscate: true
    split-debug-info: "0.0.5"
  project_id: "azkadev.packagex"
  github_username: "azkadev" 
  packages:
    - dart_target: "packagex"
      flutter_target: "main"
      dart_name: "packagex"
      flutter_name: "packagex"
msix_config:
  display_name: "packagex"
  install_certificate: false
dependency_overrides:
  pointycastle: "3.8.0"
  mime: "^2.0.0"
funding:
  - "https://github.com/sponsors/azkadev"
  - "https://github.com/sponsors/generalfoss"
issue_tracker: "https://t.me/DEVELOPER_GLOBAL_PUBLIC"
documentation: "https://youtube.com/@azkadev"


"""
    .trim();
