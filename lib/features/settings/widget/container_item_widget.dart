import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';

class ContainerItemWidget extends StatelessWidget {
  const ContainerItemWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.bottom,
    this.top,
  });

  final Function() onTap;
  final String title;
  final double? bottom;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top ?? 12, bottom: bottom ?? 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 72.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 25),
              Text(
                title,
                style: AppTextStylesMeditation.s15W400(
                  color: AppColors.color092A35,
                ),
              ),
              const Spacer(),
              Image.asset(
                AppImages.vectorRightIcon,
                height: 20,
              ),
              const SizedBox(width: 25),
            ],
          ),
        ),
      ),
    );
  }
}
