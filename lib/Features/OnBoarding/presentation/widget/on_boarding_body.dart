import 'package:flutter/material.dart';
import 'package:meto_application/config/app_colors.dart';

class OnBoardingBody extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnBoardingBody({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          Image.asset(imagePath, height: 400, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
