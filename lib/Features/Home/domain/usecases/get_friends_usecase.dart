import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/profile.dart';
import '../repositories/friends_repository.dart';

class GetFriendsUseCase {
  final FriendsRepository repository;

  GetFriendsUseCase(this.repository);

  Future<Either<Failure, List<Profile>>> call(String userId) async {
    return await repository.getFriends(userId);
  }
}
