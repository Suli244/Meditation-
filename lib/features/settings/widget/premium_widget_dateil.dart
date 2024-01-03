import 'package:flutter/material.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';

class PremiumWidgetDateil extends StatelessWidget {
  const PremiumWidgetDateil({
    super.key,
    required this.onTap,
    required this.premiuTitle,
    required this.price,
    required this.title,
    required this.titleTwo,
  });

  final Function() onTap;
  final String premiuTitle;
  final String price;
  final String title;
  final String titleTwo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 137,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.color092A35,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    premiuTitle,
                    style: AppTextStylesMeditation.s34W600(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    price,
                    style: AppTextStylesMeditation.s34W600(
                      color: AppColors.colorFFED82,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 2.50,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: AppTextStylesMeditation.s15W400(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 2.50,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          titleTwo,
                          style: AppTextStylesMeditation.s15W400(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
