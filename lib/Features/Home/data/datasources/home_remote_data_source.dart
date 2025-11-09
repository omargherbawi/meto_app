import 'package:meto_application/core/utils/supabase_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/meeting_model.dart';

class HomeRemoteDataSource {
  HomeRemoteDataSource(this.client);

  final SupabaseClient client;

  static const String _meetingsTable = 'meetings';

  Future<MeetingModel> createMeeting(MeetingModel meeting) async {
    final payload = meeting.toJson();

    final response = await SupabaseLogger.logDatabaseOperation<Map<String, dynamic>>(
      'INSERT',
      _meetingsTable,
      () => client.from(_meetingsTable).insert(payload).select().single(),
      data: payload,
    );

    return MeetingModel.fromJson(response);
  }

  Future<List<MeetingModel>> getUserMeetings(String userId) async {
    final response = await SupabaseLogger.logDatabaseOperation<List<dynamic>>(
      'SELECT',
      _meetingsTable,
      () => client.from(_meetingsTable).select().eq('owner_id', userId),
      data: {'owner_id': userId},
    );

    return response
        .cast<Map<String, dynamic>>()
        .map(MeetingModel.fromJson)
        .toList();
  }
}

