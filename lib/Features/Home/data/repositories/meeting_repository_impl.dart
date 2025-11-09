import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/repositories/meeting_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/meeting_model.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  MeetingRepositoryImpl(this.remoteDataSource);

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, Meeting>> addMeeting(Meeting meeting) async {
    return await ErrorHandler.handle(() async {
      final meetingModel = MeetingModel.fromEntity(meeting);
      final result = await remoteDataSource.createMeeting(meetingModel);
      return result;
    });
  }

  @override
  Future<Either<Failure, List<Meeting>>> getUserMeetings(String userId) async {
    return await ErrorHandler.handle(() async {
      final result = await remoteDataSource.getUserMeetings(userId);
      return result;
    });
  }
}

