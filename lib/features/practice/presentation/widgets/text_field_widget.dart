import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';

final class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
    this.hintText,
    this.suffix,
  });

  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffix;
  final Function(String value) onChanged;

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.white,
          width: 1.h,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      cursorColor: AppColors.color658525,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 24.h,
        ),
        fillColor: AppColors.white,
        filled: true,
        counterStyle: const TextStyle(color: AppColors.white),
        suffix: suffix,
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        focusedErrorBorder: _border,
        errorBorder: _border,
        // labelText: labelText,
        helperText: '',
        hintStyle: AppTextStylesMeditation.s16W400(
          color: AppColors.color50717C,
        ),
        hintText: labelText,
      ),
    );
  }
}
