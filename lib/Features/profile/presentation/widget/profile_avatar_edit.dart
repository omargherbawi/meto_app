import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/assets_paths.dart';
import '../../../../config/app_colors.dart';

class AvatarPickerWidget extends StatelessWidget {
  AvatarPickerWidget({super.key, this.width, this.height});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width ?? 140.w,
            height: height ?? 140.w,
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
                  backgroundImage: AssetImage(AssetsPaths.userAvatar),
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
              onTap:
                  // tempAvatarPath != null
                  //     ? () =>
                  //         _editAccountController.updateTempAvatarPath(null)
                  //     : null,
                  () {},
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
