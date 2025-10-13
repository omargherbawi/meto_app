import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/Features/profile/domain/usecases/add_avatar_usecase.dart';
import 'package:meto_application/Features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:meto_application/Features/profile/domain/usecases/delete_avatar_usecase.dart';
import 'package:meto_application/core/utils/either_helper.dart';

class ProfileController extends GetxController {
  final AddAvatarUseCase addAvatarUseCase;
  final UpdateAvatarUseCase updateAvatarUseCase;
  final DeleteAvatarUseCase deleteAvatarUseCase;

  ProfileController({
    required this.addAvatarUseCase,
    required this.updateAvatarUseCase,
    required this.deleteAvatarUseCase,
  });

  var isLoading = false.obs;

  Future<void> addAvatar(Uint8List imageBytes, String fileExtension) async {
    await EitherHelper.handleEither(
      addAvatarUseCase(imageBytes, fileExtension),
      onSuccess: (profile) {
        _updateAuthProfile(profile);
      },
      loading: isLoading,
    );
  }

  Future<void> updateAvatar(Uint8List imageBytes, String fileExtension, String? oldAvatarUrl) async {
    await EitherHelper.handleEither(
      updateAvatarUseCase(imageBytes, fileExtension, oldAvatarUrl),
      onSuccess: (profile) {
        _updateAuthProfile(profile);
      },
      loading: isLoading,
    );
  }

  Future<void> deleteAvatar(String avatarUrl) async {
    await EitherHelper.handleEither(
      deleteAvatarUseCase(avatarUrl),
      onSuccess: (profile) {
        _updateAuthProfile(profile);
      },
      loading: isLoading,
    );
  }

  void _updateAuthProfile(Profile updatedProfile) {
    final authController = Get.find<AuthController>();
    authController.profile.value = updatedProfile;
  }
}
