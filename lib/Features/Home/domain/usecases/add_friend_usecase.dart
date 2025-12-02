import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/friends_repository.dart';

class AddFriendUseCase {
  final FriendsRepository repository;

  AddFriendUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId, String friendId) async {
    return await repository.addFriend(userId, friendId);
  }
}
