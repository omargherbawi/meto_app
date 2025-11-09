import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/meeting.dart';
import '../repositories/meeting_repository.dart';

class AddMeeting {
  final MeetingRepository repository;

  AddMeeting(this.repository);

  Future<Either<Failure, Meeting>> call(Meeting meeting) async {
    return await repository.addMeeting(meeting);
  }
}
