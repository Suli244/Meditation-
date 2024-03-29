import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/features/home/home_page.dart';
import 'package:meditation/features/practice/presentation/cubit/practice_cubit.dart';
import 'package:meditation/features/practice/presentation/practice_page.dart';
import 'package:meditation/features/settings/settings_page.dart';
import 'package:meditation/features/useful_tips/useful_tips_page.dart';
import 'package:meditation/theme/app_colors.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key, this.currindex = 0}) : super(key: key);

  final int currindex;

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorScreen> {
  late int index = widget.currindex;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PracticeCubit(),
        )
      ],
      child: Scaffold(
        body: pages[index],
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 15,
          selectedFontSize: 15,
          currentIndex: index,
          onTap: (indexFrom) async {
            setState(() {
              index = indexFrom;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                AppImages.homeIcon,
                width: 28,
                color: AppColors.colorCDE0E7,
              ),
              activeIcon: Image.asset(
                AppImages.homeIcon,
                color: AppColors.color658525,
                width: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                AppImages.practiceIcon,
                width: 28,
                color: AppColors.colorCDE0E7,
              ),
              activeIcon: Image.asset(
                AppImages.practiceIcon,
                color: AppColors.color658525,
                width: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                AppImages.usefulTipsIcon,
                width: 28,
                color: AppColors.colorCDE0E7,
              ),
              activeIcon: Image.asset(
                AppImages.usefulTipsIcon,
                color: AppColors.color658525,
                width: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                AppImages.settingsIcon,
                width: 28,
                color: AppColors.colorCDE0E7,
              ),
              activeIcon: Image.asset(
                AppImages.settingsIcon,
                color: AppColors.color658525,
                width: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> pages = [
  const HomePage(),
  const PracticePage(),
  const UsefulTipsPage(),
  const SettingsPage(),
];
