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
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        counterStyle: const TextStyle(color: AppColors.white),
        suffix: suffix,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.h),
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        focusedErrorBorder: _border,
        errorBorder: _border,
        labelText: labelText,
        helperText: '',
        hintStyle: AppTextStylesMeditation.s16W400(fontSize: 15.h),
        hintText: hintText,
      ),
    );
  }
}
