import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meto_application/config/app_colors.dart';

class AuthTextField extends StatefulWidget {
  final String title;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final bool isPassword;

  const AuthTextField({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.keyboardType,
    this.isPassword = false, // لو الحقل باسورد
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.secondry,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.title.tr(),
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFF1A083B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
      ),
      keyboardType: widget.keyboardType,
    );
  }
}
