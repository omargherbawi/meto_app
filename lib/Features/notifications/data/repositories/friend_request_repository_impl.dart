import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../Home/data/datasources/friends_remote_data_source.dart';
import '../../domain/entities/friend_request.dart';
import '../../domain/repositories/friend_request_repository.dart';
import '../datasources/friend_request_remote_data_source.dart';

class FriendRequestRepositoryImpl implements FriendRequestRepository {
  final FriendRequestRemoteDataSource remoteDataSource;
  final FriendsRemoteDataSource friendsRemoteDataSource;

  FriendRequestRepositoryImpl(this.remoteDataSource, this.friendsRemoteDataSource);

  @override
  Future<Either<Failure, List<FriendRequest>>> getPendingRequests(String userId) async {
    try {
      final requests = await remoteDataSource.getPendingRequests(userId);
      return Right(requests);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FriendRequest>>> getSentRequests(String userId) async {
    try {
      final requests = await remoteDataSource.getSentRequests(userId);
      return Right(requests);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest(String fromUserId, String toUserId) async {
    try {
      await remoteDataSource.sendFriendRequest(fromUserId, toUserId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptFriendRequest(String requestId, String fromUserId, String toUserId) async {
    try {
      // First, update the request status to accepted
      await remoteDataSource.acceptFriendRequest(requestId);
      // Then, add both users as friends (bidirectional)
      await friendsRemoteDataSource.addFriend(fromUserId, toUserId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectFriendRequest(String requestId) async {
    try {
      await remoteDataSource.rejectFriendRequest(requestId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFriendRequest(String requestId) async {
    try {
      await remoteDataSource.cancelFriendRequest(requestId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkExistingRequest(String fromUserId, String toUserId) async {
    try {
      final exists = await remoteDataSource.checkExistingRequest(fromUserId, toUserId);
      return Right(exists);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

