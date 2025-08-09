import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meto_application/Features/OnBoarding/presentation/widget/on_boarding_body.dart';

class OnBoardingPageView extends StatelessWidget {
  final PageController pageController;
  final List<Map<String, String>> pages;
  final ValueChanged<int> onPageChanged;

  const OnBoardingPageView({
    super.key,
    required this.pageController,
    required this.pages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final page = pages[index];
          return OnBoardingBody(
            title: page['title']!.tr(),
            subtitle: page['subtitle']!.tr(),
            imagePath: page['image']!,
          );
        },
      ),
    );
  }
}
