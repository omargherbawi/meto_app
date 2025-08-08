import 'package:flutter/material.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/on_boarding_actions.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/on_boarding_page_view.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/page_indexing.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Find Your People!',
      'subtitle':
          'Create meetings and bring people together, wherever you are.',
      'image': 'assets/images/on_bording_1.png',
    },
    {
      'title': 'Organize Effortlessly',
      'subtitle': 'Plan, schedule, and manage your events with ease.',
      'image': 'assets/images/on_bording_2.png',
    },
    {
      'title': 'Stay Connected',
      'subtitle': 'Never miss an update. Stay in touch with your group.',
      'image': 'assets/images/on_bording_3.png',
    },
  ];

  void _onSkip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: Navigate to main app or home screen
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
