class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? traceId;
  final Map<String, List<String>>? fieldErrors;

  const ApiException({
    required this.message,
    this.statusCode,
    this.traceId,
    this.fieldErrors,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}
