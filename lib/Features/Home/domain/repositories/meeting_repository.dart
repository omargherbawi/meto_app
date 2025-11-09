import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/meeting.dart';

abstract class MeetingRepository {
  Future<Either<Failure, Meeting>> addMeeting(Meeting meeting);
  Future<Either<Failure, List<Meeting>>> getUserMeetings(String userId);
}