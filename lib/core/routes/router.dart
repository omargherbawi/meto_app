import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:meto_application/Features/OnBoarding/presentation/views/on_boarding.dart';

import 'route_paths.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(name: RoutePaths.onBording, page: () => const OnBoarding()),
  ];
}
