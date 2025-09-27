// Example usage of the logging system

import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/supabase_logger.dart';
import '../utils/http_logger.dart';
import '../utils/network_logger.dart';

/// Example service showing how to use the logging system
class ExampleService {
  final SupabaseClient supabaseClient;

  ExampleService(this.supabaseClient);

  /// Example: Logged Supabase operations
  Future<void> exampleSupabaseOperations() async {
    // Authentication operations
    await SupabaseLogger.logAuthOperation(
      'LOGIN',
      () => supabaseClient.auth.signInWithPassword(
        email: 'test@example.com',
        password: 'password123',
      ),
    );

    // Database operations
    await SupabaseLogger.logDatabaseOperation(
      'INSERT',
      'users',
      () => supabaseClient.from('users').insert({
        'name': 'John Doe',
        'email': 'john@example.com',
      }),
      data: {'name': 'John Doe', 'email': 'john@example.com'},
    );

    // Select operation
    await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'users',
      () => supabaseClient
          .from('users')
          .select()
          .eq('email', 'john@example.com')
          .single(),
      data: {'email': 'john@example.com'},
    );

    // Update operation
    await SupabaseLogger.logDatabaseOperation(
      'UPDATE',
      'users',
      () => supabaseClient
          .from('users')
          .update({'name': 'John Updated'})
          .eq('id', 'user-id'),
      data: {'name': 'John Updated', 'id': 'user-id'},
    );

    // Delete operation
    await SupabaseLogger.logDatabaseOperation(
      'DELETE',
      'users',
      () => supabaseClient
          .from('users')
          .delete()
          .eq('id', 'user-id'),
      data: {'id': 'user-id'},
    );
  }

  /// Example: Logged HTTP operations
  Future<void> exampleHttpOperations() async {
    // GET request
    final getResponse = await LoggedHttpClient.get(
      Uri.parse('https://api.example.com/users'),
      headers: {
        'Authorization': 'Bearer token123',
        'Content-Type': 'application/json',
      },
    );
    print('GET Response Status: ${getResponse.statusCode}');

    // POST request
    final postResponse = await LoggedHttpClient.post(
      Uri.parse('https://api.example.com/users'),
      headers: {
        'Authorization': 'Bearer token123',
        'Content-Type': 'application/json',
      },
      body: {
        'name': 'John Doe',
        'email': 'john@example.com',
      },
    );
    print('POST Response Status: ${postResponse.statusCode}');

    // PUT request
    final putResponse = await LoggedHttpClient.put(
      Uri.parse('https://api.example.com/users/123'),
      headers: {
        'Authorization': 'Bearer token123',
        'Content-Type': 'application/json',
      },
      body: {
        'name': 'John Updated',
      },
    );
    print('PUT Response Status: ${putResponse.statusCode}');

    // DELETE request
    final deleteResponse = await LoggedHttpClient.delete(
      Uri.parse('https://api.example.com/users/123'),
      headers: {
        'Authorization': 'Bearer token123',
      },
    );
    print('DELETE Response Status: ${deleteResponse.statusCode}');
  }

  /// Example: Custom network logging
  Future<void> exampleCustomLogging() async {
    // Log custom network info
    NetworkLogger.logInfo(
      'Starting user synchronization',
      data: {
        'user_count': 150,
        'last_sync': DateTime.now().toIso8601String(),
      },
    );

    // Log warnings
    NetworkLogger.logWarning(
      'Rate limit approaching',
      data: {
        'current_requests': 95,
        'limit': 100,
        'reset_time': DateTime.now().add(const Duration(minutes: 1)).toIso8601String(),
      },
    );

    // Log custom request
    NetworkLogger.logRequest(
      method: 'POST',
      url: 'https://api.example.com/custom-endpoint',
      body: {
        'action': 'sync',
        'data': ['item1', 'item2', 'item3'],
      },
    );

    // Log custom response
    NetworkLogger.logResponse(
      method: 'POST',
      url: 'https://api.example.com/custom-endpoint',
      statusCode: 200,
      body: {
        'synced_items': 3,
        'errors': [],
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Example: How to use in your existing services
class UserService {
  final SupabaseClient supabaseClient;

  UserService(this.supabaseClient);

  /// Get user profile with logging
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    return await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'profiles',
      () => supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle(),
      data: {'user_id': userId},
    );
  }

  /// Update user profile with logging
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    await SupabaseLogger.logDatabaseOperation(
      'UPDATE',
      'profiles',
      () => supabaseClient
          .from('profiles')
          .update(updates)
          .eq('id', userId),
      data: {'user_id': userId, 'updates': updates},
    );
  }

  /// Upload user avatar with logging
  Future<String> uploadUserAvatar(String userId, List<int> imageBytes) async {
    return await SupabaseLogger.logStorageOperation(
      'UPLOAD',
      'avatars',
      () async {
        // Simulate file upload
        final fileName = 'avatar_$userId.jpg';
        // In real implementation, you would upload to Supabase storage
        return 'https://storage.example.com/avatars/$fileName';
      },
      metadata: {
        'user_id': userId,
        'file_size': imageBytes.length,
        'file_type': 'image/jpeg',
      },
    );
  }
}
