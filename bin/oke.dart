import 'dart:convert';
import 'dart:io';

void main() async {
  // Mengatur direktori chroot
  Directory chrootDir = Directory('/var/chroot');
  
  // Menjalankan perintah chroot dalam proses terpisah
  Process shell = await Process.start(
    'chroot', 
    ['/var/chroot', 'bash'],
    runInShell: true,
    workingDirectory: chrootDir.path,
  );
  stdin.listen((event) {
    shell.stdin.write(utf8.decode(event));
  });
  shell.stdout.listen(
    (event) {
      stdout.write(utf8.decode(event));
    },
    onDone: () {
      exit(0);

    },
  );
  shell.stderr.listen(
    (event) {
      stderr.write(utf8.decode(event));
    },
    onDone: () {
      exit(0);
    },
  );
 
}
