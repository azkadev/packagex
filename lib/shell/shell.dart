// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:async';

import 'package:universal_io/io.dart';

Future<void> shell({
  required String executable,
  required List<String> arguments,
  String? workingDirectory,
  Map<String, String>? environment,
  bool includeParentEnvironment = true,
  bool runInShell = true,
  ProcessStartMode mode = ProcessStartMode.normal,
  required void Function(
    List<int> data,
    String executable,
    List<String> arguments,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment,
    bool runInShell,
    ProcessStartMode mode,
  ) onStdout,
  required void Function(
    List<int> data,
    String executable,
    List<String> arguments,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment,
    bool runInShell,
    ProcessStartMode mode,
  ) onStderr,
}) async {
  bool is_complete = false;
  Process shell = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    environment: environment,
    includeParentEnvironment: includeParentEnvironment,
    runInShell: runInShell,
    mode: mode,
  );
  Completer completer = Completer();

  var stdout_shell = shell.stdout.listen(
    (List<int> data) {
      onStdout(data, executable, arguments, workingDirectory, environment,
          includeParentEnvironment, runInShell, mode);
    },
    onDone: () {
      completer.complete();
      // is_complete = true;
    },
    cancelOnError: true,
  );
  var stderr_shell = shell.stderr.listen(
    (List<int> data) {
      onStderr(data, executable, arguments, workingDirectory, environment,
          includeParentEnvironment, runInShell, mode);
    },
    onDone: () {
      // is_complete = true;
      completer.complete();
    },
    cancelOnError: true,
  );

  // while (true) {
  // await Future.delayed(Duration(milliseconds: 1));
  await completer.future;
  // if (is_complete) {
  await stdout_shell.cancel();

  await stderr_shell.cancel();
  shell.kill(ProcessSignal.sigkill);
  return;
  // }
  // }
}
