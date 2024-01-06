import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:meditation/core/icons/my_flutter_app_icons.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/practice/data/model/practice_model.dart';
import 'package:meditation/features/practice/presentation/child_pages/music_detail_page.dart';
import 'package:meditation/features/practice/presentation/cubit/practice_cubit.dart';
import 'package:meditation/features/practice/presentation/widgets/cached_image_widget.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/text_field_widget.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

//TODO: clear after connedted with firebase
bool isFavorite = false;
String cstmImage =
    'https://img.freepik.com/free-photo/nature-journey-travel-trekking-summertime-concept-vertical-shot-pathway-park-leading-forested-area-outdoor-view-wooden-boardwalk-along-tall-pine-trees-morning-forest_343059-3064.jpg';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colordfe8cd,
      appBar: CustomAppBarMeditation(
        title: 'Practice',
        titleTextStyle: AppTextStylesMeditation.s26W600(
          color: AppColors.color092A35,
        ),
      ),
      body: AnimationLimiter(
        child: RefreshIndicator.adaptive(
          onRefresh: () async => context.read<PracticeCubit>().getPractice(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                TextFieldWidget(
                  onChanged: (value) =>
                      context.read<PracticeCubit>().searchList(value),
                  controller: _searchController,
                  labelText: 'Choose Sound',
                ),
                Expanded(
                  child: BlocBuilder<PracticeCubit, PracticeState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => GridViewBuilderWidget(
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: double.infinity,
                              width: 219.w,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.4),
                                highlightColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        error: (error) => Center(
                          child: Text(error),
                        ),
                        success: (model) => GridViewBuilderWidget(
                          itemCount: model.length,
                          itemBuilder: (BuildContext context, int index) =>
                              AnimationConfiguration.staggeredGrid(
                            columnCount: 14,
                            position: index,
                            delay: const Duration(milliseconds: 90),
                            child: SlideAnimation(
                              verticalOffset: 500.0,
                              child: FadeInAnimation(
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(milliseconds: 1500),
                                child: _GritViewItem(
                                  index,
                                  model: model,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _GritViewItem extends StatefulWidget {
  const _GritViewItem(
    this.index, {
    Key? key,
    required this.model,
  }) : super(key: key);

  final int index;
  final List<PracticeModel> model;

  @override
  __GritViewItemState createState() => __GritViewItemState();
}

class __GritViewItemState extends State<_GritViewItem> {
  late double heartPositionY;
  bool byPremium = false;

  @override
  void initState() {
    getPremium();
    super.initState();
    heartPositionY = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadfavorite();
    });
  }

  getPremium() async {
    byPremium = await PremiumMetitation.getPremium();
    setState(() {});
  }

  List<bool> boolList = <bool>[];

  Future<void> loadfavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    boolList = (prefs.getStringList("userfavorite2") ?? <bool>[])
        .map((value) => value == 'true')
        .toList();

    if (boolList.isEmpty) {
      boolList = List.generate(15, (index) => false).toList();
    }
    log('data: boolList: $boolList ');
    setState(() {});
  }

  Future<void> saved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    boolList[widget.index] = !boolList[widget.index];
    setState(() {});
    await prefs.setStringList(
        "userfavorite2", boolList.map((value) => value.toString()).toList());
    boolList = (prefs.getStringList("userfavorite2") ?? <bool>[])
        .map((value) => value == 'true')
        .toList();
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    log('data: boolList: ${widget.model.length} ');
    return GestureDetector(
      onTap: () {
        if (widget.model[widget.index].premium && !byPremium) {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const BottomNavigatorScreen(currindex: 3),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              transitionDuration: const Duration(
                seconds: 0,
              ), // Устанавливаем продолжительность анимации в 0 секунд
            ),
            (route) => false,
          );
        } else {
          ////MusicDetailPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicDetailPage(
                currIndex: widget.index,
                model: widget.model,
              ),
            ),
          );
        }
      },
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 136,
              child: Stack(
                children: [
                  CachedImageWidget(image: widget.model[widget.index].image),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      height: 30,
                      width: 30,
                      child: AnimatedContainer(
                        height: 30,
                        width: 30,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutBack,
                        transform: Matrix4.translationValues(
                          0,
                          heartPositionY,
                          0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              heartPositionY = -10;
                              saved();
                            });

                            Future.delayed(const Duration(milliseconds: 800),
                                () {
                              setState(() {
                                heartPositionY = 0;
                              });
                            });
                          },
                          child: Icon(
                            MyFlutterApp.vector,
                            size: 15,
                            color: boolList[widget.index]
                                ? Colors.red
                                : AppColors.colorAADC46,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.model[widget.index].premium && !byPremium)
                    Container(
                      height: 178.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: const Icon(Icons.lock),
                    )
                ],
              ),
            ),
            const Spacer(flex: 3),
            FittedBox(
              child: Text(
                widget.model[widget.index].title,
                style: const TextStyle(
                  color: Color(0xFF092A35),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 0.09,
                ),
                maxLines: 3,
                textScaleFactor: FontSizer.textScaleFactor(context),
              ),
            ),
            const Spacer(flex: 2),
            Text(
              '${widget.model[widget.index].time} Minutes',
              style: const TextStyle(
                color: Color(0xFF4F707B),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 0.13,
              ),
              textScaleFactor: FontSizer.textScaleFactor(context),
            ),
          ],
        ),
      ),
    );
  }
}

final class GridViewBuilderWidget extends StatelessWidget {
  const GridViewBuilderWidget({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        mainAxisExtent: 217,
      ),
      itemCount: itemCount,
      physics: const ScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      itemBuilder: itemBuilder,
    );
  }
}
