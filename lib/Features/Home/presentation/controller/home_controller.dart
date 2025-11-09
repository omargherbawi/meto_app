import 'package:get/get.dart';

import '../../../../core/utils/either_helper.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/usecases/add_meeting.dart';
import '../../domain/usecases/fetch_user_meeting.dart';

class HomeController extends GetxController {
  HomeController({
    required this.addMeetingUseCase,
    required this.fetchUserMeetingUseCase,
  });

  final AddMeeting addMeetingUseCase;
  final FetchUserMeeting fetchUserMeetingUseCase;

  final RxList<Meeting> meetings = <Meeting>[].obs;
  final RxBool isLoadingMeetings = false.obs;
  final RxBool isCreatingMeeting = false.obs;

  Future<void> loadMeetings(String userId) async {
    await EitherHelper.handleEither(
      fetchUserMeetingUseCase(userId),
      onSuccess: (result) => meetings.assignAll(result),
      loading: isLoadingMeetings,
    );
  }

  Future<bool> createMeeting(
    Meeting meeting, {
    bool refreshAfterCreate = true,
  }) async {
    var isSuccessful = false;

    await EitherHelper.handleEither<Meeting>(
      addMeetingUseCase(meeting),
      loading: isCreatingMeeting,
      onSuccess: (Meeting createdMeeting) {
        isSuccessful = true;
        if (refreshAfterCreate) {
          loadMeetings(createdMeeting.ownerId);
        } else {
          meetings.add(createdMeeting);
        }
      },
    );

    return isSuccessful;
  }
}

