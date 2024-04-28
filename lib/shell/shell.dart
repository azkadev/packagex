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
// // ignore_for_file: non_constant_identifier_names, unused_local_variable

// import 'dart:async';

// import 'package:universal_io/io.dart';

// Future<void> shell({
//   required String executable,
//   required List<String> arguments,
//   String? workingDirectory,
//   Map<String, String>? environment,
//   bool includeParentEnvironment = true,
//   bool runInShell = true,
//   ProcessStartMode mode = ProcessStartMode.normal,
//   required void Function(
//     List<int> data,
//     String executable,
//     List<String> arguments,
//     String? workingDirectory,
//     Map<String, String>? environment,
//     bool includeParentEnvironment,
//     bool runInShell,
//     ProcessStartMode mode,
//   ) onStdout,
//   required void Function(
//     List<int> data,
//     String executable,
//     List<String> arguments,
//     String? workingDirectory,
//     Map<String, String>? environment,
//     bool includeParentEnvironment,
//     bool runInShell,
//     ProcessStartMode mode,
//   ) onStderr,
// }) async {
//   bool is_complete = false;
//   Process shell = await Process.start(
//     executable,
//     arguments,
//     workingDirectory: workingDirectory,
//     environment: environment,
//     includeParentEnvironment: includeParentEnvironment,
//     runInShell: runInShell,
//     mode: mode,
//   );

//   var stdout_shell = shell.stdout.listen(
//     (List<int> data) {
//       onStdout(data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode);
//     },
//   );
//   var stderr_shell = shell.stderr.listen(
//     (List<int> data) {
//       onStderr(data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode);
//     },
//   );

//   // while (true) {
//   // await Future.delayed(Duration(milliseconds: 1));
//   await shell.exitCode;
//   // if (is_complete) {
//   await stdout_shell.cancel();

//   await stderr_shell.cancel();
//   return;
//   // }
//   // }
// }
