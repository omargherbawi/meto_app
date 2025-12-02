import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/friend_request.dart';

abstract class FriendRequestRepository {
  Future<Either<Failure, List<FriendRequest>>> getPendingRequests(String userId);
  Future<Either<Failure, List<FriendRequest>>> getSentRequests(String userId);
  Future<Either<Failure, void>> sendFriendRequest(String fromUserId, String toUserId);
  Future<Either<Failure, void>> acceptFriendRequest(String requestId, String fromUserId, String toUserId);
  Future<Either<Failure, void>> rejectFriendRequest(String requestId);
  Future<Either<Failure, void>> cancelFriendRequest(String requestId);
  Future<Either<Failure, bool>> checkExistingRequest(String fromUserId, String toUserId);
}

