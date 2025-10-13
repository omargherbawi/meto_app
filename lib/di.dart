import 'package:get/get.dart';
import 'package:meto_application/Features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:meto_application/Features/auth/data/repositories/auth_repository_impl.dart';
import 'package:meto_application/Features/auth/domain/repositories/auth_repository.dart';
import 'package:meto_application/Features/auth/domain/usecases/login_usecase.dart';
import 'package:meto_application/Features/auth/domain/usecases/logout_usecase.dart';
import 'package:meto_application/Features/auth/domain/usecases/signup_usecase.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/core/services/hive_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DependencyInjection {
  static void init() {
    // Core Services
    Get.put<HiveServices>(HiveServices(), permanent: true);

    // Auth Dependencies
    Get.lazyPut(() => AuthRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => SignupUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));

    // Controllers
    Get.put(
      AuthController(
        loginUseCase: Get.find(),
        signupUseCase: Get.find(),
        logoutUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
