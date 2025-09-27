import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Simple Supabase logger that wraps operations and logs them
class SupabaseLogger {
  static const String _tag = '🔥 SUPABASE';

  /// Log authentication operations
  static Future<AuthResponse> logAuthOperation(
    String operation,
    Future<AuthResponse> Function() operationFunction,
  ) async {
    if (!kDebugMode) return await operationFunction();

    final requestId = _generateRequestId();
    final startTime = DateTime.now();

    dev.log(
      '''
🚀 AUTH $operation [$requestId]
Operation: $operation
''',
      name: _tag,
    );

    try {
      final response = await operationFunction();
      final duration = DateTime.now().difference(startTime);
      final statusCode = response.user != null ? 200 : 400;
      final statusEmoji = _getStatusEmoji(statusCode);

      dev.log(
        '''
$statusEmoji AUTH $operation RESPONSE [$requestId] (${duration.inMilliseconds}ms)
Status: ${statusCode == 200 ? 'SUCCESS' : 'FAILED'}
User ID: ${response.user?.id ?? 'null'}
Email: ${response.user?.email ?? 'null'}
Session Exists: ${response.session != null}
''',
        name: _tag,
      );

      return response;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      dev.log(
        '''
❌ AUTH $operation ERROR [$requestId] (${duration.inMilliseconds}ms)
Error: $error
''',
        name: _tag,
      );

      rethrow;
    }
  }

  /// Log database operations
  static Future<T> logDatabaseOperation<T>(
    String operation,
    String table,
    Future<T> Function() operationFunction, {
    Map<String, dynamic>? data,
  }) async {
    if (!kDebugMode) return await operationFunction();

    final requestId = _generateRequestId();
    final startTime = DateTime.now();

    dev.log(
      '''
🚀 DB $operation [$requestId]
Table: $table
${data != null ? 'Data: ${_formatJson(data)}' : ''}
''',
      name: _tag,
    );

    try {
      final result = await operationFunction();
      final duration = DateTime.now().difference(startTime);

      dev.log(
        '''
✅ DB $operation RESPONSE [$requestId] (${duration.inMilliseconds}ms)
Table: $table
Result: ${_formatResult(result)}
''',
        name: _tag,
      );

      return result;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      dev.log(
        '''
❌ DB $operation ERROR [$requestId] (${duration.inMilliseconds}ms)
Table: $table
Error: $error
''',
        name: _tag,
      );

      rethrow;
    }
  }

  /// Log storage operations
  static Future<T> logStorageOperation<T>(
    String operation,
    String bucket,
    Future<T> Function() operationFunction, {
    Map<String, dynamic>? metadata,
  }) async {
    if (!kDebugMode) return await operationFunction();

    final requestId = _generateRequestId();
    final startTime = DateTime.now();

    dev.log(
      '''
🚀 STORAGE $operation [$requestId]
Bucket: $bucket
${metadata != null ? 'Metadata: ${_formatJson(metadata)}' : ''}
''',
      name: _tag,
    );

    try {
      final result = await operationFunction();
      final duration = DateTime.now().difference(startTime);

      dev.log(
        '''
✅ STORAGE $operation RESPONSE [$requestId] (${duration.inMilliseconds}ms)
Bucket: $bucket
Result: ${_formatResult(result)}
''',
        name: _tag,
      );

      return result;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      dev.log(
        '''
❌ STORAGE $operation ERROR [$requestId] (${duration.inMilliseconds}ms)
Bucket: $bucket
Error: $error
''',
        name: _tag,
      );

      rethrow;
    }
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

  static String _formatResult(dynamic result) {
    if (result == null) return 'null';
    
    if (result is List) {
      return 'List with ${result.length} items';
    }
    
    if (result is Map) {
      return 'Map with ${result.length} keys';
    }
    
    if (result is String) {
      try {
        // Try to parse as JSON for pretty printing
        final jsonData = jsonDecode(result);
        return const JsonEncoder.withIndent('  ').convert(jsonData);
      } catch (e) {
        return result.length > 100 ? '${result.substring(0, 100)}...' : result;
      }
    }
    
    return result.toString();
  }
}
