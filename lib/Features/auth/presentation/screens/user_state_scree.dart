import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import 'package:meto_application/core/services/hive_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserStateScreen extends StatelessWidget {
  const UserStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });

    return Scaffold(
      backgroundColor: Color(0xff613FDA),
      body: Center(child: SizedBox(child: Image.asset(AssetsPaths.splash))),
    );
  }

  Future<void> checkUserState() async {
    await Future.delayed(const Duration(milliseconds: 100));

    final hiveService = Get.find<HiveServices>();
    final session = Supabase.instance.client.auth.currentSession;
    final isOnBoardingShown = hiveService.getIsOnBoardingShown();

    if (!isOnBoardingShown) {
      Get.offAllNamed(RoutePaths.onBording);
    } else if (session != null) {
      Get.offAllNamed(RoutePaths.home);
    } else {
      Get.offAllNamed(RoutePaths.login);
    }
  }
}
