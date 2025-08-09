import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:meto_application/Features/OnBoarding/presentation/screens/on_boarding.dart';
import 'package:meto_application/Features/auth/presentation/screens/login.dart';

import 'route_paths.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(name: RoutePaths.onBording, page: () => const OnBoarding()),
    GetPage(name: RoutePaths.login, page: () => const Login()),
  ];
}
