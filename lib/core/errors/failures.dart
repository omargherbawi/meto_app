import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Server failure - when something goes wrong on the server side
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Network failure - when there's no internet connection or network issues
class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

/// Cache failure - when local storage operations fail
class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

/// Authentication failure - when user authentication fails
class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}

/// Validation failure - when input validation fails
class ValidationFailure extends Failure {
  const ValidationFailure([super.message]);
}

/// Permission failure - when user doesn't have required permissions
class PermissionFailure extends Failure {
  const PermissionFailure([super.message]);
}

/// Unknown failure - for unexpected errors
class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}

/// Timeout failure - when operations take too long
class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message]);
}

/// Not found failure - when requested resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);
}

/// Unauthorized failure - when user is not authorized
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);
}

/// Forbidden failure - when user doesn't have access to resource
class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message]);
}

/// Conflict failure - when there's a conflict with the current state
class ConflictFailure extends Failure {
  const ConflictFailure([super.message]);
}

/// Rate limit failure - when too many requests are made
class RateLimitFailure extends Failure {
  const RateLimitFailure([super.message]);
}
