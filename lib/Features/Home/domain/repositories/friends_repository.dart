import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/profile.dart';

abstract class FriendsRepository {
  Future<Either<Failure, List<Profile>>> getFriends(String userId);
  Future<Either<Failure, void>> addFriend(String userId, String friendId);
  Future<Either<Failure, void>> removeFriend(String userId, String friendId);
  Future<Either<Failure, List<Profile>>> searchUsers(String query);
}
