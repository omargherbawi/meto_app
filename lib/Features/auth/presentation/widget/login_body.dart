import 'package:flutter/material.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.asset(AssetsPaths.login, fit: BoxFit.cover),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(children: [
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
