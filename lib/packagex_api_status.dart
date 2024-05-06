// ignore_for_file: non_constant_identifier_names, constant_identifier_names
 
/// Packagex Api Status Type 
enum PackagexApiStatusType {
  succes,
  failed,
  info,
  start,
  progress_start,
  progress,
  progress_complete,
}

/// Packagex Api Status 
class PackagexApiStatus { 
  String value;
  
  PackagexApiStatusType packagexApiStatusType;
  /// Packagex Api Status
  PackagexApiStatus({ 
    required this.packagexApiStatusType,
    required this.value,
  });
}
