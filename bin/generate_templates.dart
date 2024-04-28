import 'dart:io';
import 'package:general_lib/script_generate/extensions.dart';
import 'package:general_lib/script_generate/script_generate_core.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  Directory directory = Directory(path.join(Directory.current.path, "example"));
  List<ScriptGenerator> scriptGenerators =
      directory.listSync().toScriptGenerate();
  scriptGenerators
      .generateToDirectory(
          directoryBase:
              Directory(path.join(Directory.current.path, "example_program")))
      .listen((event) {
    print(event.text);
  });
}
