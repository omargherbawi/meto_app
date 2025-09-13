import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:meto_application/Features/Home/presentation/screens/home._screen.dart';
import 'package:meto_application/Features/meetings/presentation/screens/meeting_members.dart';
import 'package:meto_application/Features/meetings/presentation/screens/meeting_screen.dart';
import 'package:meto_application/Features/OnBoarding/presentation/screens/on_boarding.dart';
import 'package:meto_application/Features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:meto_application/Features/auth/presentation/screens/login_screen.dart';
import 'package:meto_application/Features/auth/presentation/screens/signup_screen.dart';

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

    GetPage(
      name: RoutePaths.forgotPassword,
      page: () => const ForgotPassword(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    ),

    GetPage(
      name: RoutePaths.home,
      page: () => const Home(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    ),

    GetPage(
      name: RoutePaths.meeting,
      page: () => const MeetingScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: RoutePaths.members,
      page: () => const MeetingMembers(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ),
  ];
}
