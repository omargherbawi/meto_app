import 'package:get/get.dart';
import 'package:meto_application/core/utils/either_helper.dart';
import '../../../auth/domain/entities/profile.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../../domain/usecases/add_friend_usecase.dart';
import '../../domain/usecases/get_friends_usecase.dart';
import '../../domain/usecases/remove_friend_usecase.dart';
import '../../domain/usecases/search_users_usecase.dart';

class FriendsController extends GetxController {
  final GetFriendsUseCase getFriendsUseCase;
  final AddFriendUseCase addFriendUseCase;
  final RemoveFriendUseCase removeFriendUseCase;
  final SearchUsersUseCase searchUsersUseCase;

  FriendsController({
    required this.getFriendsUseCase,
    required this.addFriendUseCase,
    required this.removeFriendUseCase,
    required this.searchUsersUseCase,
  });

  var friends = <Profile>[].obs;
  var searchResults = <Profile>[].obs;
  var isLoading = false.obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFriends();
  }

  /// Call this when user logs out or changes account
  void clearFriends() {
    friends.clear();
    searchResults.clear();
  }

  Future<void> loadFriends() async {
    final authController = Get.find<AuthController>();
    final userId = authController.profile.value?.id;
    if (userId == null) {
      friends.clear();
      return;
    }

    await EitherHelper.handleEither<List<Profile>>(
      getFriendsUseCase(userId),
      onSuccess: (data) {
        friends.value = data;
      },
      loading: isLoading,
    );
  }

  Future<void> addFriend(String friendId) async {
    final authController = Get.find<AuthController>();
    final userId = authController.profile.value?.id;
    if (userId == null) return;

    await EitherHelper.handleEitherVoid(
      addFriendUseCase(userId, friendId),
      onSuccess: () {
        Get.snackbar("Success", "Friend added successfully");
        loadFriends();
        searchResults.clear(); // Clear search results after adding
        Get.back(); // Close bottom sheet
      },
      loading: isLoading,
    );
  }

  Future<void> removeFriend(String friendId) async {
    final authController = Get.find<AuthController>();
    final userId = authController.profile.value?.id;
    if (userId == null) return;

    await EitherHelper.handleEitherVoid(
      removeFriendUseCase(userId, friendId),
      onSuccess: () {
        Get.snackbar("Success", "Friend removed successfully");
        loadFriends();
      },
      loading: isLoading,
    );
  }

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    await EitherHelper.handleEither<List<Profile>>(
      searchUsersUseCase(query),
      onSuccess: (data) {
        // Filter out self and existing friends
        final authController = Get.find<AuthController>();
        final currentUserId = authController.profile.value?.id;
        final friendIds = friends.map((f) => f.id).toSet();

        searchResults.value = data.where((user) {
          return user.id != currentUserId && !friendIds.contains(user.id);
        }).toList();
      },
      loading: isSearching,
    );
  }
}
