import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/friend_request_repository.dart';

class AcceptFriendRequestUseCase {
  final FriendRequestRepository repository;

  AcceptFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call(String requestId, String fromUserId, String toUserId) async {
    return await repository.acceptFriendRequest(requestId, fromUserId, toUserId);
  }
}

