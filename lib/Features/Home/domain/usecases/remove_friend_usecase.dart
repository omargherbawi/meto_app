import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/friends_repository.dart';

class RemoveFriendUseCase {
  final FriendsRepository repository;

  RemoveFriendUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId, String friendId) async {
    return await repository.removeFriend(userId, friendId);
  }
}
