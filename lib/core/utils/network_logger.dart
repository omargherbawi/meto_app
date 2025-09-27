import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// Network logger utility to log all HTTP requests and responses
class NetworkLogger {
  static const String _tag = '🌐 NETWORK';

  /// Log HTTP request details
  static void logRequest({
    required String method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    dynamic body,
    String? requestId,
  }) {
    if (!kDebugMode) return;

    final String id = requestId ?? _generateRequestId();
    
    dev.log(
      '''
🚀 REQUEST [$id]
Method: $method
URL: $url
${queryParameters != null && queryParameters.isNotEmpty ? 'Query Parameters: ${_formatJson(queryParameters)}' : ''}
${headers != null && headers.isNotEmpty ? 'Headers: ${_formatJson(headers)}' : ''}
${body != null ? 'Body: ${_formatBody(body)}' : ''}
''',
      name: _tag,
    );
  }

  /// Log HTTP response details
  static void logResponse({
    required String method,
    required String url,
    required int statusCode,
    Map<String, String>? headers,
    dynamic body,
    String? requestId,
    Duration? duration,
  }) {
    if (!kDebugMode) return;

    final String id = requestId ?? _generateRequestId();
    final String statusEmoji = _getStatusEmoji(statusCode);
    final String durationText = duration != null ? ' (${duration.inMilliseconds}ms)' : '';

    dev.log(
      '''
$statusEmoji RESPONSE [$id]$durationText
Method: $method
URL: $url
Status Code: $statusCode
${headers != null && headers.isNotEmpty ? 'Headers: ${_formatJson(headers)}' : ''}
${body != null ? 'Body: ${_formatBody(body)}' : ''}
''',
      name: _tag,
    );
  }

  /// Log HTTP error details
  static void logError({
    required String method,
    required String url,
    required dynamic error,
    String? requestId,
    Duration? duration,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    final String id = requestId ?? _generateRequestId();
    final String durationText = duration != null ? ' (${duration.inMilliseconds}ms)' : '';

    dev.log(
      '''
❌ ERROR [$id]$durationText
Method: $method
URL: $url
Error: $error
${stackTrace != null ? 'StackTrace: $stackTrace' : ''}
''',
      name: _tag,
    );
  }

  /// Log general network information
  static void logInfo(String message, {Map<String, dynamic>? data}) {
    if (!kDebugMode) return;

    dev.log(
      '''
ℹ️ INFO: $message
${data != null ? 'Data: ${_formatJson(data)}' : ''}
''',
      name: _tag,
    );
  }

  /// Log network warning
  static void logWarning(String message, {Map<String, dynamic>? data}) {
    if (!kDebugMode) return;

    dev.log(
      '''
⚠️ WARNING: $message
${data != null ? 'Data: ${_formatJson(data)}' : ''}
''',
      name: _tag,
    );
  }

  /// Helper methods
  static String _generateRequestId() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(8);
  }

  static String _getStatusEmoji(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) return '✅';
    if (statusCode >= 300 && statusCode < 400) return '🔄';
    if (statusCode >= 400 && statusCode < 500) return '⚠️';
    if (statusCode >= 500) return '❌';
    return '❓';
  }

  static String _formatJson(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (e) {
      return data.toString();
    }
  }

  static String _formatBody(dynamic body) {
    if (body == null) return 'null';
    
    if (body is String) {
      try {
        // Try to parse as JSON for pretty printing
        final jsonData = jsonDecode(body);
        return const JsonEncoder.withIndent('  ').convert(jsonData);
      } catch (e) {
        return body;
      }
    }
    
    if (body is Map || body is List) {
      return _formatJson(body);
    }
    
    return body.toString();
  }
}
