import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_picker/image_picker.dart';
import 'package:meto_application/config/app_colors.dart';

class AvatarOptionsBottomSheet extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;
  final VoidCallback? onDelete;
  final bool showDeleteOption;

  const AvatarOptionsBottomSheet({
    super.key,
    required this.onImageSourceSelected,
    this.onDelete,
    this.showDeleteOption = false,
  });

  static void show({
    required Function(ImageSource) onImageSourceSelected,
    VoidCallback? onDelete,
    bool showDeleteOption = false,
  }) {
    Get.bottomSheet(
      AvatarOptionsBottomSheet(
        onImageSourceSelected: onImageSourceSelected,
        onDelete: onDelete,
        showDeleteOption: showDeleteOption,
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          
          // Title
          Text(
            'AvatarOptions'.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Take Photo option
          ListTile(
            leading: const Icon(Icons.camera_alt, color: AppColors.primaryColor),
            title: Text('TakePhoto'.tr()),
            onTap: () {
              Get.back();
              onImageSourceSelected(ImageSource.camera);
            },
          ),
          
          // Choose from Gallery option
          ListTile(
            leading: const Icon(Icons.photo_library, color: AppColors.primaryColor),
            title: Text('ChooseFromGallery'.tr()),
            onTap: () {
              Get.back();
              onImageSourceSelected(ImageSource.gallery);
            },
          ),
          
          // Delete option (conditional)
          if (showDeleteOption && onDelete != null)
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(
                'DeleteAvatar'.tr(),
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                Get.back();
                onDelete!();
              },
            ),
          
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

