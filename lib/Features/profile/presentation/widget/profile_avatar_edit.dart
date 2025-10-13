import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/utils/toast_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/app_colors.dart';

class AvatarPickerWidget extends StatelessWidget {
  AvatarPickerWidget({super.key, this.width, this.height});

  final double? height;
  final double? width;

  Future<void> _pickAndUploadImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image == null) return;

      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final bytes = await image.readAsBytes();
      final fileExt = image.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;

      // Upload to Supabase Storage
      final supabase = Supabase.instance.client;
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              contentType: 'image/$fileExt',
            ),
          );

      // Get the public URL
      final imageUrl = supabase.storage
          .from('avatars')
          .getPublicUrl(filePath);

      // Update user profile with new avatar URL
      await supabase
          .from('profiles')
          .update({'avatar_url': imageUrl})
          .eq('id', supabase.auth.currentUser!.id);

      // Update local profile state
      final authController = Get.find<AuthController>();
      if (authController.profile.value != null) {
        final currentProfile = authController.profile.value!;
        final updatedProfile = Profile(
          id: currentProfile.id,
          email: currentProfile.email,
          name: currentProfile.name,
          avatarUrl: imageUrl,
        );
        authController.profile.value = updatedProfile;
      }

      Get.back(); // Close loading dialog
      ToastUtils.showSuccess('Profile picture updated successfully');
    } catch (error) {
      Get.back(); // Close loading dialog
      ToastUtils.showError('Failed to update profile picture');
      print('Error uploading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userProfile = authController.profile.value;
    return GestureDetector(
      onTap: () => _pickAndUploadImage(context),
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
            child:
                // tempAvatarPath != null
                //     ? ClipOval(
                //       child: Image.file(
                //         File(tempAvatarPath),
                //         fit: BoxFit.cover,
                //       ),
                //     )
                //     : avatarUrl != null
                //     ?
                CircleAvatar(
                  radius: 70.r,
                  backgroundImage: userProfile?.avatarUrl != null
                      ? NetworkImage(userProfile!.avatarUrl!)
                      : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
                ),
            // : SvgPicture.asset(
            //   AssetPaths.personOutline,
            //   width: 40.w,
            //   fit: BoxFit.scaleDown,
            // ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _pickAndUploadImage(context),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      // tempAvatarPath != null
                      //     ? SharedColors.redColor
                      //     :
                      AppColors.primaryColor,
                ),
                width: 27.w,
                height: 27.w,
                child: Icon(
                  Icons.mode_edit_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
                // tempAvatarPath != null
                //     ?
                // SvgPicture.asset(
                //   AssetsPaths.edit,
                //   height: 36.h,
                //   width: 36.h,
                // ),
                // : Icon(
                //   tempAvatarPath != null
                //       ? CupertinoIcons.delete
                //       : avatarUrl != null
                //       ? Icons.edit
                //       : Icons.add,
                //   color: Theme.of(context).colorScheme.onSurface,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
