import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/on_boarding_actions.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/on_boarding_page_view.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/page_indexing.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import 'package:meto_application/core/services/hive_service.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final HiveServices _hiveService = Get.find<HiveServices>();

  final List<Map<String, String>> _pages = [
    {
      'title': 'FindYourPeople',
      'subtitle': 'createMeeting',
      'image': AssetsPaths.onBoarding1,
    },
    {
      'title': 'OrganizeEffortlessly',
      'subtitle': 'Plan',
      'image': AssetsPaths.onBoarding2,
    },
    {
      'title': 'StayConnected',
      'subtitle': 'NeverMissUpdate',
      'image': AssetsPaths.onBoarding3,
    },
  ];

  void _onSkip() {
    _hiveService.setIsOnBoardingShown(true);
    Get.offAllNamed(RoutePaths.login);
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _hiveService.setIsOnBoardingShown(true);
      Get.offAllNamed(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnBoardingPageView(
              pages: _pages,
              pageController: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            PageIndexing(pages: _pages, currentPage: _currentPage),

            OnboardindActions(
              onSkip: _onSkip,
              onNext: _onNext,
              isLastPage: _currentPage == _pages.length - 1,
            ),
          ],
        ),
      ),
    );
  }
}
