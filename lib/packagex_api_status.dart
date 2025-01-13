// ignore_for_file: non_constant_identifier_names, constant_identifier_names

/// Packagex Api Status Type
enum PackagexApiStatusType {
  /// UncompleteDocumentation
  succes,

  /// UncompleteDocumentation
  failed,

  /// UncompleteDocumentation
  info,

  /// UncompleteDocumentation
  start,

  /// UncompleteDocumentation
  progress_start,

  /// UncompleteDocumentation
  progress,

  /// UncompleteDocumentation
  progress_complete,
}

/// Packagex Api Status
class PackagexApiStatus {
  /// UncompleteDocumentation
  String value;

  /// UncompleteDocumentation

  PackagexApiStatusType packagexApiStatusType;

  /// Packagex Api Status
  PackagexApiStatus({
    required this.packagexApiStatusType,
    required this.value,
  });
}
