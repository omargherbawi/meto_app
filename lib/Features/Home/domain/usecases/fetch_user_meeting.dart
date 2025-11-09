import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/meeting.dart';
import '../repositories/meeting_repository.dart';

class FetchUserMeeting {
   final MeetingRepository repository;

  FetchUserMeeting(this.repository);

  Future<Either<Failure, List<Meeting>>> call(String userId) async {
    return await repository.getUserMeetings(userId);
  }
}