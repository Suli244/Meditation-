import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';

class PageViewItemMeditation extends StatelessWidget {
  const PageViewItemMeditation({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          alignment: Alignment.bottomCenter,
          image,
          height: 480.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: AppTextStylesMeditation.s34W600(
                      color: AppColors.color092A35,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                FittedBox(
                  child: Text(
                    subTitle,
                    style: AppTextStylesMeditation.s15W400(
                      color: AppColors.color50717C,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
