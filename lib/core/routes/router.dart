import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:meto_application/Features/OnBoarding/presentation/screens/on_boarding.dart';
import 'package:meto_application/Features/auth/presentation/screens/login.dart';
import 'package:meto_application/Features/auth/presentation/screens/signup.dart';

import 'route_paths.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutePaths.onBording, 
      page: () => const OnBoarding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    ),
    GetPage(
      name: RoutePaths.login, 
      page: () => const Login(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: RoutePaths.signup, 
      page: () => const SignUp(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    ),
  ];
}
