// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorLogEntry _$ErrorLogEntryFromJson(Map<String, dynamic> json) =>
    _ErrorLogEntry(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      category: json['category'] as String,
      message: json['message'] as String,
      technicalMessage: json['technicalMessage'] as String?,
      stackTrace: json['stackTrace'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      apiErrorKind: json['apiErrorKind'] as String?,
      traceId: json['traceId'] as String?,
      endpoint: json['endpoint'] as String?,
      httpMethod: json['httpMethod'] as String?,
      featureName: json['featureName'] as String?,
      isHandled: json['isHandled'] as bool? ?? true,
    );

Map<String, dynamic> _$ErrorLogEntryToJson(_ErrorLogEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'category': instance.category,
      'message': instance.message,
      'technicalMessage': instance.technicalMessage,
      'stackTrace': instance.stackTrace,
      'statusCode': instance.statusCode,
      'apiErrorKind': instance.apiErrorKind,
      'traceId': instance.traceId,
      'endpoint': instance.endpoint,
      'httpMethod': instance.httpMethod,
      'featureName': instance.featureName,
      'isHandled': instance.isHandled,
    };
