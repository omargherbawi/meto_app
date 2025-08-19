import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meto_application/core/utils/check_tablet.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.backgroundColor = Colors.transparent,
    this.leading,
    this.centerTitle = true,
    this.bottom,
    this.flexibleSpace,
    this.popPath,
    this.popOnePage,
    this.onBack,
    this.actions,
    this.systemUI,
    this.titleHeroTag,
    this.leadingWidth,
    this.roundButton = true,
    this.toolbarHeight,
    this.isLocalize = true,
  });

  final String? title;
  final Widget? titleWidget;
  final SystemUiOverlayStyle? systemUI;
  final Color backgroundColor;
  final Widget? leading;
  final bool centerTitle;
  final bool roundButton;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final String? popPath;
  final bool? popOnePage;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final String? titleHeroTag;
  final double? leadingWidth;
  final double? toolbarHeight;
  final bool isLocalize;

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: MediaQuery.of(context).viewInsets.top + 10,
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: toolbarHeight,
        systemOverlayStyle: systemUI ?? SystemUiOverlayStyle.dark,
        actions: actions,
        flexibleSpace: flexibleSpace,
        leadingWidth: leadingWidth ?? 40.w,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        leading:
            leading ??
            (roundButton
                ? IconButton(
                  
                  iconSize:
                      (Responsive.isTablet ? 8.w : 25),
                  icon: const Icon(Icons.arrow_back_ios),
             onPressed:
                      onBack ??
                      () {
                        Get.back();
                      },
                 
                )
               
                : IconButton(
                  padding: EdgeInsets.zero,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed:
                      onBack ??
                      () {
                        log("HERE IS THE ISSUE");
                        try {
                          Get.back();
                        } catch (e) {
                          log("GETX ERROR: $e");
                        }
                      },
                  icon: const Icon(Icons.arrow_back_ios),
                )),
        title:
            titleWidget ??
            (titleHeroTag != null
                ? Hero(
                  tag: titleHeroTag!,
                  child: Text(
                    title ?? "",
                   style: TextStyle(fontSize:  Responsive.isTablet ? 10 : 18,),
                 
                  ),
                )
                : Text(
                  title ?? "",
                  style: TextStyle(fontSize: Responsive.isTablet ? 6 : 16,)
                )),
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
