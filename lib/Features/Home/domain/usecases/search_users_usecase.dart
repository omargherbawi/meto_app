import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/profile.dart';
import '../repositories/friends_repository.dart';

class SearchUsersUseCase {
  final FriendsRepository repository;

  SearchUsersUseCase(this.repository);

  Future<Either<Failure, List<Profile>>> call(String query) async {
    return await repository.searchUsers(query);
  }
}
