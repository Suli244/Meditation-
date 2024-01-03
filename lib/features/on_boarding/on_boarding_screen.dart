import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/core/premium/first_open.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/on_boarding/widget/page_view_item_meditation.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int currantPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      currantPage = value;
                    });
                  },
                  children: const [
                    PageViewItemMeditation(
                      image: AppImages.onbordingOne,
                      title: 'Begin Your Journey\nof Serenity',
                      subTitle:
                          'Embark on a transformative path to tranquility and\nself-awareness with CalmBreath Meditation.',
                    ),
                    PageViewItemMeditation(
                      image: AppImages.onbordingTwo,
                      title: 'Customize Your\nCalm',
                      subTitle:
                          'Tailor your meditation experience to your personal\nneeds, choosing from a variety of focused themes.',
                    ),
                    PageViewItemMeditation(
                      image: AppImages.onbordingThree,
                      title: 'Track Your Tranquil\nProgress',
                      subTitle:
                          'Monitor your meditation journey, observe your\ngrowth, and feel the lasting impact of daily\npractice.',
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 450.h,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.color658525,
                        dotColor: Colors.white,
                        dotHeight: 8,
                        dotWidth: 7,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CustomButtonMeditation(
                color: AppColors.color658525,
                onPress: () async {
                  if (currantPage == 2) {
                    await FirstOpenMeditation.setFirstOpen();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigatorScreen(),
                      ),
                      (protected) => false,
                    );
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                text: currantPage == 2 ? 'Start now' : 'Next',
              ),
            ),
          )
        ],
      ),
    );
  }
}
