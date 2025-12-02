import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/friend_request_repository.dart';

class RejectFriendRequestUseCase {
  final FriendRequestRepository repository;

  RejectFriendRequestUseCase(this.repository);

  Future<Either<Failure, void>> call(String requestId) async {
    return await repository.rejectFriendRequest(requestId);
  }
}

