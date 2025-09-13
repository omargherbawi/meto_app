import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.tilteSytle = const TextStyle(
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    this.leadingIconColor = AppColors.white,
  });

  final String? title;
  final Color leadingIconColor;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final SystemUiOverlayStyle? systemUI;
  final List<Widget>? actions;
  final TextStyle tilteSytle;

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
            icon: Icon(Icons.arrow_back_ios_new, color: leadingIconColor),
          ),
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      centerTitle: true,
      title: Text(title!.tr(), style: tilteSytle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
