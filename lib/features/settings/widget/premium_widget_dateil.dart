import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_button.dart';

class PremiumWidgetDateil extends StatefulWidget {
  const PremiumWidgetDateil({
    super.key,
  });

  @override
  State<PremiumWidgetDateil> createState() => _PremiumWidgetDateilState();
}

class _PremiumWidgetDateilState extends State<PremiumWidgetDateil> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.color092A35,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Premium',
                style: AppTextStylesMeditation.s34W600(
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '0.99\$',
                style: AppTextStylesMeditation.s34W600(
                  color: AppColors.colorFFED82,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• Unlocks 60% of content',
                  style: AppTextStylesMeditation.s15W400(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '• No ads',
                  style: AppTextStylesMeditation.s15W400(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          CustomButtonMeditation(
            isLoading: load,
            color: Colors.white,
            textColor: AppColors.color092A35,
            onPress: () async {
              setState(() {
                load = true;
              });
              final apphudPaywalls = await Apphud.paywalls();

              await Apphud.purchase(
                product: apphudPaywalls?.paywalls.first.products?.first,
              ).whenComplete(
                () async {
                  if (await Apphud.hasPremiumAccess() ||
                      await Apphud.hasActiveSubscription()) {
                    await PremiumMetitation.restoreMeditation(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BottomNavigatorScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              );
              setState(() {
                load = false;
              });
            },
            text: 'Buy premium',
          )
        ],
      ),
    );
  }
}
