import 'package:get/get.dart';
import 'package:meto_application/Features/auth/domain/repositories/auth_repository.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRemoteDataSource(Supabase.instance.client));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));

    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => SignupUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => GetProfileUseCase(Get.find()));

    Get.put(
      AuthController(
        loginUseCase: Get.find(),
        signupUseCase: Get.find(),
        logoutUseCase: Get.find(),
        getProfileUseCase: Get.find(),
      ),
    );
  }
}
