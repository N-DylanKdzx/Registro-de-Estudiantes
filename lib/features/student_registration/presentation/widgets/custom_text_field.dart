import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_registration/core/theme/app_theme.dart';

/// Widget personalizado para campos de texto con diseño minimalista
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.textSecondary,
          size: 22,
        ),
      ),
    );
  }
}
