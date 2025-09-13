import 'package:flutter/material.dart';
import 'package:meto_application/Features/profile/presentation/widget/profile_settings_body.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';

class ProfleSettingsScreen extends StatelessWidget {
  const ProfleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.white,
        leadingIconColor: AppColors.primaryColor,
      ),
      body: ProfleSettingsBody(),
    );
  }
}
