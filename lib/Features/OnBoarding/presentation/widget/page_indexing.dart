import 'package:flutter/material.dart';
import 'package:meto_application/config/app_colors.dart';

class PageIndexing extends StatelessWidget {
  const PageIndexing({
    super.key,
    required List<Map<String, String>> pages,
    required int currentPage,
  }) : _pages = pages,
       _currentPage = currentPage;

  final List<Map<String, String>> _pages;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          width: _currentPage == index ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppColors.primaryColor
                : Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
