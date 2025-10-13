import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/Features/profile/presentation/controller/profile_controller.dart';
import 'package:meto_application/Features/profile/presentation/widget/avatar_options_bottom_sheet.dart';
import 'package:meto_application/config/assets_paths.dart';
import '../../../../config/app_colors.dart';

class AvatarPickerWidget extends StatelessWidget {
  AvatarPickerWidget({super.key, this.width, this.height});

  final double? height;
  final double? width;

  Future<void> _pickAndUploadImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    
    if (image == null) return;

    final bytes = await image.readAsBytes();
    final fileExt = image.path.split('.').last;
    
    final authController = Get.find<AuthController>();
    final profileController = Get.find<ProfileController>();
    final currentAvatarUrl = authController.profile.value?.avatarUrl;

    // Use appropriate use case based on whether user has existing avatar
    if (currentAvatarUrl != null && currentAvatarUrl.isNotEmpty) {
      await profileController.updateAvatar(bytes, fileExt, currentAvatarUrl);
    } else {
      await profileController.addAvatar(bytes, fileExt);
    }
  }

  void _showAvatarOptions(BuildContext context) {
    final authController = Get.find<AuthController>();
    final profileController = Get.find<ProfileController>();
    final currentAvatarUrl = authController.profile.value?.avatarUrl;
    final hasAvatar = currentAvatarUrl != null && currentAvatarUrl.isNotEmpty;
    
    AvatarOptionsBottomSheet.show(
      onImageSourceSelected: (source) => _pickAndUploadImage(context, source),
      showDeleteOption: hasAvatar,
      onDelete: hasAvatar
          ? () => profileController.deleteAvatar(currentAvatarUrl)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final profileController = Get.find<ProfileController>();
    
    return Obx(() {
      final userProfile = authController.profile.value;
      final isLoading = profileController.isLoading.value;
      
      return GestureDetector(
        onTap: isLoading ? null : () => _showAvatarOptions(context),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width ?? 160.w,
              height: height ?? 160.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              child: isLoading
                  ? CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Colors.grey[200],
                      child: const CircularProgressIndicator(),
                    )
                  : CircleAvatar(
                      radius: 70.r,
                      backgroundImage: userProfile?.avatarUrl != null && userProfile!.avatarUrl!.isNotEmpty
                          ? CachedNetworkImageProvider(userProfile.avatarUrl!)
                          : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
                    ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTap: isLoading ? null : () => _showAvatarOptions(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  width: 27.w,
                  height: 27.w,
                  child: Icon(
                    Icons.mode_edit_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
