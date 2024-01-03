import 'package:flutter/material.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_app_bar.dart';

class UsefulTipsPage extends StatelessWidget {
  const UsefulTipsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colordfe8cd,
      appBar: CustomAppBarMeditation(
        title: 'Useful Tips',
        titleTextStyle:
            AppTextStylesMeditation.s26W600(color: AppColors.color092A35),
      ),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}
