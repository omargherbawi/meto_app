import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/friend_request_repository.dart';

class SendFriendRequestUseCase {
  final FriendRequestRepository repository;

  SendFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call(String fromUserId, String toUserId) async {
    return await repository.sendFriendRequest(fromUserId, toUserId);
  }
}

