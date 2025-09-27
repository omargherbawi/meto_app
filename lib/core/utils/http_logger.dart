import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// HTTP client with comprehensive logging
class LoggedHttpClient {
  static final http.Client _client = http.Client();

  /// GET request with logging
  static Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
    String? requestId,
  }) async {
    final id = requestId ?? _generateRequestId();
    final startTime = DateTime.now();

    if (kDebugMode) {
      dev.log(
        '''
🚀 GET REQUEST [$id]
URL: $url
${headers != null && headers.isNotEmpty ? 'Headers: ${_formatJson(headers)}' : ''}
''',
        name: '🌐 HTTP',
      );
    }

    try {
      final response = await _client.get(url, headers: headers);
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        final statusEmoji = _getStatusEmoji(response.statusCode);
        dev.log(
          '''
$statusEmoji GET RESPONSE [$id] (${duration.inMilliseconds}ms)
URL: $url
Status Code: ${response.statusCode}
${response.headers.isNotEmpty ? 'Headers: ${_formatJson(response.headers)}' : ''}
Body: ${_formatBody(response.body)}
''',
          name: '🌐 HTTP',
        );
      }

      return response;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        dev.log(
          '''
❌ GET ERROR [$id] (${duration.inMilliseconds}ms)
URL: $url
Error: $error
''',
          name: '🌐 HTTP',
        );
      }

      rethrow;
    }
  }

  /// POST request with logging
  static Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    String? requestId,
  }) async {
    final id = requestId ?? _generateRequestId();
    final startTime = DateTime.now();

    if (kDebugMode) {
      dev.log(
        '''
🚀 POST REQUEST [$id]
URL: $url
${headers != null && headers.isNotEmpty ? 'Headers: ${_formatJson(headers)}' : ''}
${body != null ? 'Body: ${_formatBody(body)}' : ''}
''',
        name: '🌐 HTTP',
      );
    }

    try {
      final response = await _client.post(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
      );
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        final statusEmoji = _getStatusEmoji(response.statusCode);
        dev.log(
          '''
$statusEmoji POST RESPONSE [$id] (${duration.inMilliseconds}ms)
URL: $url
Status Code: ${response.statusCode}
${response.headers.isNotEmpty ? 'Headers: ${_formatJson(response.headers)}' : ''}
Body: ${_formatBody(response.body)}
''',
          name: '🌐 HTTP',
        );
      }

      return response;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        dev.log(
          '''
❌ POST ERROR [$id] (${duration.inMilliseconds}ms)
URL: $url
Error: $error
''',
          name: '🌐 HTTP',
        );
      }

      rethrow;
    }
  }

  /// PUT request with logging
  static Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    String? requestId,
  }) async {
    final id = requestId ?? _generateRequestId();
    final startTime = DateTime.now();

    if (kDebugMode) {
      dev.log(
        '''
🚀 PUT REQUEST [$id]
URL: $url
${headers != null && headers.isNotEmpty ? 'Headers: ${_formatJson(headers)}' : ''}
${body != null ? 'Body: ${_formatBody(body)}' : ''}
''',
        name: '🌐 HTTP',
      );
    }

    try {
      final response = await _client.put(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
      );
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        final statusEmoji = _getStatusEmoji(response.statusCode);
        dev.log(
          '''
$statusEmoji PUT RESPONSE [$id] (${duration.inMilliseconds}ms)
URL: $url
Status Code: ${response.statusCode}
${response.headers.isNotEmpty ? 'Headers: ${_formatJson(response.headers)}' : ''}
Body: ${_formatBody(response.body)}
''',
          name: '🌐 HTTP',
        );
      }

      return response;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        dev.log(
          '''
❌ PUT ERROR [$id] (${duration.inMilliseconds}ms)
URL: $url
Error: $error
''',
          name: '🌐 HTTP',
        );
      }

      rethrow;
    }
  }

  /// DELETE request with logging
  static Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    String? requestId,
  }) async {
    final id = requestId ?? _generateRequestId();
    final startTime = DateTime.now();

    if (kDebugMode) {
      dev.log(
        '''
🚀 DELETE REQUEST [$id]
URL: $url
${headers != null && headers.isNotEmpty ? 'Headers: ${_formatJson(headers)}' : ''}
${body != null ? 'Body: ${_formatBody(body)}' : ''}
''',
        name: '🌐 HTTP',
      );
    }

    try {
      final response = await _client.delete(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
      );
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        final statusEmoji = _getStatusEmoji(response.statusCode);
        dev.log(
          '''
$statusEmoji DELETE RESPONSE [$id] (${duration.inMilliseconds}ms)
URL: $url
Status Code: ${response.statusCode}
${response.headers.isNotEmpty ? 'Headers: ${_formatJson(response.headers)}' : ''}
Body: ${_formatBody(response.body)}
''',
          name: '🌐 HTTP',
        );
      }

      return response;
    } catch (error) {
      final duration = DateTime.now().difference(startTime);

      if (kDebugMode) {
        dev.log(
          '''
❌ DELETE ERROR [$id] (${duration.inMilliseconds}ms)
URL: $url
Error: $error
''',
          name: '🌐 HTTP',
        );
      }

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

  /// Close the HTTP client
  static void close() {
    _client.close();
  }
}
