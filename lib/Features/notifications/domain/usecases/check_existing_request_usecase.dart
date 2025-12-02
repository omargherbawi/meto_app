import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/friend_request_repository.dart';

class CheckExistingRequestUseCase {
  final FriendRequestRepository repository;

  CheckExistingRequestUseCase(this.repository);

  Future<Either<Failure, bool>> call(String fromUserId, String toUserId) async {
    return await repository.checkExistingRequest(fromUserId, toUserId);
  }
}

