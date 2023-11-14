import "package:universal_io/io.dart";

extension PackageBuildExtension on Directory {
  Future<void> autoCreate() async {
    if (!existsSync()) {
      await create(recursive: true);
    }
    return;
  }
}
