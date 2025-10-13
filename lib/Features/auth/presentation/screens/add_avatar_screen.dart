import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_picker/image_picker.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/Features/profile/presentation/controller/profile_controller.dart';
import 'package:meto_application/Features/profile/presentation/widget/avatar_options_bottom_sheet.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';

class AddAvatarScreen extends StatefulWidget {
  const AddAvatarScreen({super.key});

  @override
  State<AddAvatarScreen> createState() => _AddAvatarScreenState();
}

class _AddAvatarScreenState extends State<AddAvatarScreen> {
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();
  
  var selectedImageBytes = Rxn<Uint8List>();
  String? _fileExtension;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    
    if (image == null) return;

    final bytes = await image.readAsBytes();
    final fileExt = image.path.split('.').last;

    selectedImageBytes.value = bytes;
    _fileExtension = fileExt;
  }

  void _showImageSourceOptions() {
    final hasImage = selectedImageBytes.value != null;
    
    AvatarOptionsBottomSheet.show(
      onImageSourceSelected: _pickImage,
      showDeleteOption: hasImage,
      onDelete: hasImage
          ? () {
              setState(() {
                selectedImageBytes.value = null;
                _fileExtension = null;
              });
            }
          : null,
    );
  }

  Future<void> _continue() async {
    if (selectedImageBytes.value != null && _fileExtension != null) {
      await profileController.addAvatar(
        selectedImageBytes.value!,
        _fileExtension!,
      );
    }
    Get.offAllNamed(RoutePaths.home);
  }

  void _skip() {
    Get.offAllNamed(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Skip'.tr(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // Title
              Text(
                'AddProfilePhoto'.tr(),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              
              SizedBox(height: 12.h),
              
              // Subtitle
              Text(
                'AddPhotoSubtitle'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: 60.h),
              
              // Avatar Preview
              Obx(() {
                final imageBytes = selectedImageBytes.value;
                return GestureDetector(
                  onTap: _showImageSourceOptions,
                  child: Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 100.r,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: imageBytes != null
                              ? MemoryImage(imageBytes)
                              : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              imageBytes != null ? Icons.edit : Icons.add_a_photo,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              
              SizedBox(height: 40.h),
             
              
              const Spacer(),
              
              // Continue button
              Obx(() {
                final isLoading = profileController.isLoading.value;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(double.infinity, 56.h),
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : _continue,
                  child: isLoading
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          selectedImageBytes.value != null 
                              ? 'Continue'.tr()
                              : 'ContinueWithoutPhoto'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              }),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

