part of packagex;

extension PackageBuildExtension on Directory {
  Future<void> autoCreate() async {
    if (!existsSync()) {
      await create(recursive: true);
    }
    return;
  }
}
