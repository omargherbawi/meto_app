import 'package:get/get.dart';
import 'package:meto_application/Features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:meto_application/Features/auth/data/repositories/auth_repository_impl.dart';
import 'package:meto_application/Features/auth/domain/repositories/auth_repository.dart';
import 'package:meto_application/Features/auth/domain/usecases/login_usecase.dart';
import 'package:meto_application/Features/auth/domain/usecases/logout_usecase.dart';
import 'package:meto_application/Features/auth/domain/usecases/signup_usecase.dart';
import 'package:meto_application/Features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/Features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:meto_application/Features/profile/data/repositories/profile_repository_impl.dart';
import 'package:meto_application/Features/profile/domain/repositories/profile_repository.dart';
import 'package:meto_application/Features/profile/domain/usecases/add_avatar_usecase.dart';
import 'package:meto_application/Features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:meto_application/Features/profile/domain/usecases/delete_avatar_usecase.dart';
import 'package:meto_application/Features/profile/presentation/controller/profile_controller.dart';
import 'package:meto_application/Features/Home/data/datasources/friends_remote_data_source.dart';
import 'package:meto_application/Features/Home/data/repositories/friends_repository_impl.dart';
import 'package:meto_application/Features/Home/domain/repositories/friends_repository.dart';
import 'package:meto_application/Features/Home/domain/usecases/add_friend_usecase.dart';
import 'package:meto_application/Features/Home/domain/usecases/get_friends_usecase.dart';
import 'package:meto_application/Features/Home/domain/usecases/remove_friend_usecase.dart';
import 'package:meto_application/Features/Home/domain/usecases/search_users_usecase.dart';
import 'package:meto_application/Features/Home/presentation/controller/friends_controller.dart';
import 'package:meto_application/Features/Home/data/datasources/home_remote_data_source.dart';
import 'package:meto_application/Features/Home/data/repositories/meeting_repository_impl.dart';
import 'package:meto_application/Features/Home/domain/repositories/meeting_repository.dart';
import 'package:meto_application/Features/Home/domain/usecases/add_meeting.dart';
import 'package:meto_application/Features/Home/domain/usecases/fetch_user_meeting.dart';
import 'package:meto_application/Features/Home/presentation/controller/home_controller.dart';
import 'package:meto_application/Features/notifications/data/datasources/friend_request_remote_data_source.dart';
import 'package:meto_application/Features/notifications/data/repositories/friend_request_repository_impl.dart';
import 'package:meto_application/Features/notifications/domain/repositories/friend_request_repository.dart';
import 'package:meto_application/Features/notifications/domain/usecases/get_pending_requests_usecase.dart';
import 'package:meto_application/Features/notifications/domain/usecases/send_friend_request_usecase.dart';
import 'package:meto_application/Features/notifications/domain/usecases/accept_friend_request_usecase.dart';
import 'package:meto_application/Features/notifications/domain/usecases/reject_friend_request_usecase.dart';
import 'package:meto_application/Features/notifications/domain/usecases/check_existing_request_usecase.dart';
import 'package:meto_application/Features/notifications/presentation/controller/friend_request_controller.dart';
import 'package:meto_application/core/services/hive_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DependencyInjection {
  static void init() {
    // Core Services
    Get.put<HiveServices>(HiveServices(), permanent: true);

    // Auth Dependencies
    Get.lazyPut(() => AuthRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => SignupUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => GetProfileUseCase(Get.find()));

    // Profile Dependencies
    Get.lazyPut(() => ProfileRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<ProfileRepository>(() => ProfileRepositoryImpl(Get.find()));
    Get.lazyPut(() => AddAvatarUseCase(Get.find()));
    Get.lazyPut(() => UpdateAvatarUseCase(Get.find()));
    Get.lazyPut(() => DeleteAvatarUseCase(Get.find()));

    // Home Dependencies
    Get.lazyPut(() => HomeRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<MeetingRepository>(() => MeetingRepositoryImpl(Get.find()));
    Get.lazyPut(() => AddMeeting(Get.find()));
    Get.lazyPut(() => FetchUserMeeting(Get.find()));

    // Friends Dependencies
    Get.lazyPut(() => FriendsRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<FriendsRepository>(() => FriendsRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetFriendsUseCase(Get.find()));
    Get.lazyPut(() => AddFriendUseCase(Get.find()));
    Get.lazyPut(() => RemoveFriendUseCase(Get.find()));
    Get.lazyPut(() => SearchUsersUseCase(Get.find()));

    // Friend Request Dependencies
    Get.lazyPut(() => FriendRequestRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<FriendRequestRepository>(() => FriendRequestRepositoryImpl(
      Get.find<FriendRequestRemoteDataSource>(),
      Get.find<FriendsRemoteDataSource>(),
    ));
    Get.lazyPut(() => GetPendingRequestsUseCase(Get.find()));
    Get.lazyPut(() => SendFriendRequestUseCase(Get.find()));
    Get.lazyPut(() => AcceptFriendRequestUseCase(Get.find()));
    Get.lazyPut(() => RejectFriendRequestUseCase(Get.find()));
    Get.lazyPut(() => CheckExistingRequestUseCase(Get.find()));


    // Controllers
    Get.put(
      AuthController(
        loginUseCase: Get.find(),
        signupUseCase: Get.find(),
        logoutUseCase: Get.find(),
        getProfileUseCase: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      HomeController(
        addMeetingUseCase: Get.find(),
        fetchUserMeetingUseCase: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      FriendsController(
        getFriendsUseCase: Get.find(),
        addFriendUseCase: Get.find(),
        removeFriendUseCase: Get.find(),
        searchUsersUseCase: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      FriendRequestController(
        getPendingRequestsUseCase: Get.find(),
        sendFriendRequestUseCase: Get.find(),
        acceptFriendRequestUseCase: Get.find(),
        rejectFriendRequestUseCase: Get.find(),
        checkExistingRequestUseCase: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      ProfileController(
        addAvatarUseCase: Get.find(),
        updateAvatarUseCase: Get.find(),
        deleteAvatarUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
