import 'package:flutter/material.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/settings/widget/container_item_widget.dart';
import 'package:meditation/features/settings/widget/premium_widget_dateil.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    getPremium();
    super.initState();
  }

  bool isPremium = false;

  getPremium() async {
    isPremium = await PremiumMetitation.getPremium();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colordfe8cd,
      appBar: CustomAppBarMeditation(
        centerTitle: false,
        title: 'Settings',
        titleTextStyle:
            AppTextStylesMeditation.s34W600(color: AppColors.color092A35),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ContainerItemWidget(
                onTap: () {},
                title: 'Privacy policy',
              ),
              ContainerItemWidget(
                onTap: () {},
                title: 'Terms of use',
              ),
              ContainerItemWidget(
                onTap: () {},
                title: 'Support',
              ),
              ContainerItemWidget(
                onTap: () {},
                title: 'Restore purchases',
                bottom: 12,
              ),
              if (!isPremium) Image.asset(AppImages.premiumBanner),
              const Spacer(),
              Text(
                'The app is created for informative purposes. In case of anxiety or poor inner state, we advise you to consult a specialist.',
                style: AppTextStylesMeditation.s15W400(
                  color: AppColors.color658525,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
