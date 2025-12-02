import 'package:get/get.dart';
import 'package:meto_application/core/services/notification_sender_service.dart';
import 'package:meto_application/core/utils/either_helper.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../../../Home/presentation/controller/friends_controller.dart';
import '../../domain/entities/friend_request.dart';
import '../../domain/usecases/get_pending_requests_usecase.dart';
import '../../domain/usecases/send_friend_request_usecase.dart';
import '../../domain/usecases/accept_friend_request_usecase.dart';
import '../../domain/usecases/reject_friend_request_usecase.dart';
import '../../domain/usecases/check_existing_request_usecase.dart';

class FriendRequestController extends GetxController {
  final GetPendingRequestsUseCase getPendingRequestsUseCase;
  final SendFriendRequestUseCase sendFriendRequestUseCase;
  final AcceptFriendRequestUseCase acceptFriendRequestUseCase;
  final RejectFriendRequestUseCase rejectFriendRequestUseCase;
  final CheckExistingRequestUseCase checkExistingRequestUseCase;

  FriendRequestController({
    required this.getPendingRequestsUseCase,
    required this.sendFriendRequestUseCase,
    required this.acceptFriendRequestUseCase,
    required this.rejectFriendRequestUseCase,
    required this.checkExistingRequestUseCase,
  });

  final _notificationService = NotificationSenderService();

  var pendingRequests = <FriendRequest>[].obs;
  var isLoading = false.obs;
  var isSending = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPendingRequests();
  }

  /// Clear all data (call on logout)
  void clearRequests() {
    pendingRequests.clear();
  }

  /// Load pending friend requests for the current user
  Future<void> loadPendingRequests() async {
    final authController = Get.find<AuthController>();
    final userId = authController.profile.value?.id;
    if (userId == null) {
      pendingRequests.clear();
      return;
    }

    await EitherHelper.handleEither<List<FriendRequest>>(
      getPendingRequestsUseCase(userId),
      onSuccess: (data) {
        pendingRequests.value = data;
      },
      loading: isLoading,
    );
  }

  /// Send a friend request to another user
  Future<bool> sendFriendRequest(String toUserId) async {
    final authController = Get.find<AuthController>();
    final fromUserId = authController.profile.value?.id;
    final fromUserName = authController.profile.value?.name ?? 'Someone';
    if (fromUserId == null) return false;

    bool success = false;

    await EitherHelper.handleEitherVoid(
      sendFriendRequestUseCase(fromUserId, toUserId),
      onSuccess: () async {
        Get.snackbar("Success", "Friend request sent!");
        success = true;
        
        // Send push notification to the receiver
        await _notificationService.sendFriendRequestNotification(
          toUserId: toUserId,
          fromUserName: fromUserName,
        );
      },
      loading: isSending,
    );

    return success;
  }

  /// Accept a friend request
  Future<void> acceptRequest(FriendRequest request) async {
    final authController = Get.find<AuthController>();
    final currentUserId = authController.profile.value?.id;
    final currentUserName = authController.profile.value?.name ?? 'Someone';
    if (currentUserId == null) return;

    await EitherHelper.handleEitherVoid(
      acceptFriendRequestUseCase(request.id, request.fromUserId, request.toUserId),
      onSuccess: () async {
        Get.snackbar("Success", "Friend request accepted!");
        // Remove from pending list
        pendingRequests.removeWhere((r) => r.id == request.id);
        // Reload friends list
        if (Get.isRegistered<FriendsController>()) {
          Get.find<FriendsController>().loadFriends();
        }
        
        // Send notification to the person who sent the request
        await _notificationService.sendFriendAcceptedNotification(
          toUserId: request.fromUserId,
          accepterName: currentUserName,
        );
      },
      loading: isLoading,
    );
  }

  /// Reject a friend request
  Future<void> rejectRequest(FriendRequest request) async {
    await EitherHelper.handleEitherVoid(
      rejectFriendRequestUseCase(request.id),
      onSuccess: () {
        Get.snackbar("Info", "Friend request rejected");
        // Remove from pending list
        pendingRequests.removeWhere((r) => r.id == request.id);
      },
      loading: isLoading,
    );
  }

  /// Check if a request already exists (to show appropriate UI)
  Future<bool> hasExistingRequest(String toUserId) async {
    final authController = Get.find<AuthController>();
    final fromUserId = authController.profile.value?.id;
    if (fromUserId == null) return false;

    bool exists = false;
    await EitherHelper.handleEither<bool>(
      checkExistingRequestUseCase(fromUserId, toUserId),
      onSuccess: (data) {
        exists = data;
      },
      loading: isLoading,
    );
    return exists;
  }

  /// Get the count of pending requests (for badge)
  int get pendingCount => pendingRequests.length;
}
