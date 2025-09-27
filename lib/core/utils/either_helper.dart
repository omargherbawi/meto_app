import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../errors/failures.dart';
import 'toast_utils.dart';

/// Helper class to make working with Either in GetX controllers easier
class EitherHelper {
  /// Execute an Either operation and handle the result in a GetX controller
  /// 
  /// [operation] - The Either operation to execute
  /// [onSuccess] - Callback for successful result
  /// [onError] - Optional callback for error handling (defaults to showing toast)
  /// [loading] - Optional observable for loading state
  static Future<void> handleEither<T>(
    Future<Either<Failure, T>> operation, {
    required void Function(T) onSuccess,
    void Function(Failure)? onError,
    RxBool? loading,
  }) async {
    if (loading != null) loading.value = true;

    try {
      final result = await operation;
      
      result.fold(
        (failure) {
          if (onError != null) {
            onError(failure);
          } else {
            ToastUtils.showFailure(failure);
          }
        },
        (data) => onSuccess(data),
      );
    } finally {
      if (loading != null) loading.value = false;
    }
  }

  /// Execute an Either operation that returns void
  static Future<void> handleEitherVoid(
    Future<Either<Failure, void>> operation, {
    required VoidCallback onSuccess,
    void Function(Failure)? onError,
    RxBool? loading,
  }) async {
    await handleEither(
      operation,
      onSuccess: (_) => onSuccess(),
      onError: onError,
      loading: loading,
    );
  }

  /// Execute multiple Either operations in sequence
  static Future<void> handleMultipleEither<T>(
    List<Future<Either<Failure, T>>> operations, {
    required void Function(List<T>) onSuccess,
    void Function(Failure)? onError,
    RxBool? loading,
  }) async {
    if (loading != null) loading.value = true;

    try {
      final results = <T>[];
      
      for (final operation in operations) {
        final result = await operation;
        
        final eitherResult = result.fold(
          (failure) {
            if (onError != null) {
              onError(failure);
            } else {
              ToastUtils.showFailure(failure);
            }
            return null;
          },
          (data) => data,
        );
        
        if (eitherResult == null) {
          return; // Stop on first error
        }
        
        results.add(eitherResult);
      }
      
      onSuccess(results);
    } finally {
      if (loading != null) loading.value = false;
    }
  }

  /// Convert an Either to a nullable value for easier handling
  static T? eitherToNullable<T>(Either<Failure, T> either) {
    return either.fold(
      (failure) => null,
      (data) => data,
    );
  }

  /// Check if an Either is successful
  static bool isSuccess<T>(Either<Failure, T> either) {
    return either.isRight();
  }

  /// Check if an Either failed
  static bool isFailure<T>(Either<Failure, T> either) {
    return either.isLeft();
  }

  /// Get the failure from an Either (returns null if successful)
  static Failure? getFailure<T>(Either<Failure, T> either) {
    return either.fold(
      (failure) => failure,
      (data) => null,
    );
  }

  /// Get the success value from an Either (returns null if failed)
  static T? getSuccess<T>(Either<Failure, T> either) {
    return either.fold(
      (failure) => null,
      (data) => data,
    );
  }
}
