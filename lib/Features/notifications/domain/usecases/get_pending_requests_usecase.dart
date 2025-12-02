import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/friend_request.dart';
import '../repositories/friend_request_repository.dart';

class GetPendingRequestsUseCase {
  final FriendRequestRepository repository;

  GetPendingRequestsUseCase(this.repository);

  Future<Either<Failure, List<FriendRequest>>> call(String userId) async {
    return await repository.getPendingRequests(userId);
  }
}

