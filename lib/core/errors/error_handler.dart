import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'failures.dart';

/// Extension to convert Supabase exceptions to our failure types
extension SupabaseExceptionExtension on AuthException {
  Failure toFailure() {
    switch (message) {
      case 'Invalid login credentials':
        return const AuthFailure('Invalidcredentials,pleasecheckyourphoneNumberorpassword');
      case 'Email not confirmed':
        return const AuthFailure('email_not_confirmed');
      case 'User already registered':
        return const AuthFailure('account_exist');
      case 'Password should be at least 6 characters':
        return const ValidationFailure('password_too_short');
      case 'Unable to validate email address: invalid format':
        return const ValidationFailure('invalid_email_format');
      default:
        return ServerFailure(message);
    }
  }
}

/// Extension to convert general exceptions to our failure types
extension ExceptionExtension on Exception {
  Failure toFailure() {
    if (this is AuthException) {
      return (this as AuthException).toFailure();
    }
    
    if (this is PostgrestException) {
      return _handlePostgrestException(this as PostgrestException);
    }
    
    if (toString().contains('SocketException') || 
        toString().contains('HandshakeException') ||
        toString().contains('TimeoutException')) {
      return const NetworkFailure('network_error');
    }
    
    return UnknownFailure(toString());
  }
  
  Failure _handlePostgrestException(PostgrestException exception) {
    switch (exception.code) {
      case 'PGRST116':
        return const NotFoundFailure('not_found');
      case '23505': // Unique violation
        return const ConflictFailure('already_exists');
      case '23503': // Foreign key violation
        return const ValidationFailure('invalid_reference');
      case '42501': // Insufficient privilege
        return const ForbiddenFailure('insufficient_privileges');
      default:
        return ServerFailure(exception.message);
    }
  }
}

/// Utility class for handling errors and converting them to Either
class ErrorHandler {
  /// Execute a function and convert any exception to a Failure
  static Future<Either<Failure, T>> handle<T>(
    Future<T> Function() function,
  ) async {
    try {
      final result = await function();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  /// Execute a synchronous function and convert any exception to a Failure
  static Either<Failure, T> handleSync<T>(
    T Function() function,
  ) {
    try {
      final result = function();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}

/// Extension to make Either handling easier
extension EitherExtension<L, R> on Either<L, R> {
  /// Fold the Either and return the right value or throw the left value
  R getOrThrow() {
    return fold(
      (l) => throw l as Object,
      (r) => r,
    );
  }

  /// Get the right value or return null
  R? getOrNull() {
    return fold(
      (l) => null,
      (r) => r,
    );
  }

  /// Get the right value or return a default value
  R getOrElse(R defaultValue) {
    return fold(
      (l) => defaultValue,
      (r) => r,
    );
  }
}
