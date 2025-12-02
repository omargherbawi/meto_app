import 'package:get/get.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import 'package:meto_application/core/utils/either_helper.dart';
import 'package:meto_application/Features/Home/presentation/controller/friends_controller.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final LogoutUseCase logoutUseCase;
  final GetProfileUseCase getProfileUseCase;

  AuthController({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.logoutUseCase,
    required this.getProfileUseCase,
  });

  var isLoading = false.obs;
  var profile = Rxn<Profile>();

  Future<void> login(String email, String password) async {
    await EitherHelper.handleEither(
      loginUseCase(email, password),
      onSuccess: (profileData) {
        profile.value = profileData;
        // Reload friends for the new user
        if (Get.isRegistered<FriendsController>()) {
          Get.find<FriendsController>().loadFriends();
        }
        Get.offAllNamed(RoutePaths.home);
      },
      loading: isLoading,
    );
  }

  Future<void> signup(String email, String password, String name) async {
    await EitherHelper.handleEither(
      signupUseCase(email, password, name),
      onSuccess: (profileData) {
        profile.value = profileData;
        // Reload friends for the new user
        if (Get.isRegistered<FriendsController>()) {
          Get.find<FriendsController>().loadFriends();
        }
        Get.offAllNamed(RoutePaths.addAvatar);
      },
      loading: isLoading,
    );
  }

  Future<void> logout() async {
    await EitherHelper.handleEitherVoid(
      logoutUseCase(),
      onSuccess: () {
        profile.value = null;
        // Clear friends list on logout
        if (Get.isRegistered<FriendsController>()) {
          Get.find<FriendsController>().clearFriends();
        }
        Get.offAllNamed(RoutePaths.login);
      },
    );
  }

  Future<void> loadCurrentUserProfile(String userId) async {
    await EitherHelper.handleEither(
      getProfileUseCase(userId),
      onSuccess: (profileData) {
        profile.value = profileData;
      },
      loading: isLoading,
    );
  }
}
