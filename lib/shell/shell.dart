// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:universal_io/io.dart';

Future<void> shell({
  required String executable,
  required List<String> arguments,
  String? workingDirectory,
  Map<String, String>? environment,
  bool includeParentEnvironment = true,
  bool runInShell = false,
  ProcessStartMode mode = ProcessStartMode.normal,
}) async {
  bool is_complete = false;
  Process shell = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
  ); 
  var stdout_shell = shell.stdout.listen(
    (event) {
      stdout.write(utf8.decode(event));
    },
    onDone: () {
      shell.kill();
      is_complete = true;
    },
    cancelOnError: true,
  );
  var stderr_shell = shell.stderr.listen(
    (event) {
      stderr.write(utf8.decode(event));
    },
    onDone: () {
      shell.kill();
      is_complete = true;
    },
    cancelOnError: true,
  );

  while (true) {
    await Future.delayed(Duration(milliseconds: 1));

    if (is_complete) {
      // await stdin_shell.cancel();
      await stdout_shell.cancel();
      await stderr_shell.cancel();
      break;
    }
  }
}
