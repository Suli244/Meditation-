import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:meditation/core/icons/my_flutter_app_icons.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/practice/data/model/just_model.dart';
import 'package:meditation/features/practice/data/model/practice_model.dart';
import 'package:meditation/features/practice/presentation/child_pages/practice_detail_page.dart';
import 'package:meditation/features/practice/presentation/cubit/practice_cubit.dart';
import 'package:meditation/features/practice/presentation/widgets/cached_image_widget.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/text_field_widget.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_app_bar.dart';
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
                                child: _GritViewItem(model[index]),
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
    this.model, {
    Key? key,
  }) : super(key: key);

  final PracticeModel model;

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
  }

  getPremium() async {
    byPremium = await PremiumMetitation.getPremium();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.model.premium && !byPremium) {
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PracticeDetailPage(
                model: JustDetailModel(
                  image: widget.model.image,
                ),
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
                  CachedImageWidget(image: widget.model.image),
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
                            });

                            Future.delayed(const Duration(milliseconds: 800),
                                () {
                              setState(() {
                                heartPositionY = 0;
                              });
                            });
                          },
                          child: const Icon(
                            MyFlutterApp.vector,
                            size: 15,
                            color: AppColors.colorAADC46,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.model.premium && !byPremium)
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
                widget.model.title,
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
              '${widget.model.time} Minutes',
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
