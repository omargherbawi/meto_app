import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meto_application/config/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = "",
    this.leading,
    this.backgroundColor,
    this.toolbarHeight,
    this.systemUI,
    this.actions,
  });

  final String? title;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final SystemUiOverlayStyle? systemUI;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      scrolledUnderElevation: 0,
      toolbarHeight: toolbarHeight,
      systemOverlayStyle: systemUI ?? SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading:
          leading ??
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          ),
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      centerTitle: true,
      title: Text(
        title!.tr(),
        style: TextStyle(
          color: AppColors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
