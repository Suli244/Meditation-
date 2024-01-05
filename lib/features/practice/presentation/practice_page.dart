import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:meditation/core/icons/my_flutter_app_icons.dart';
import 'package:meditation/features/practice/data/model/just_model.dart';
import 'package:meditation/features/practice/presentation/child_pages/practice_detail_page.dart';
import 'package:meditation/features/practice/presentation/widgets/cached_image_widget.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/text_field_widget.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_app_bar.dart';

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
          onRefresh: () async {},
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                TextFieldWidget(
                  controller: _searchController,
                  labelText: 'Choose Sound',
                ),
                GridView.builder(
                  key: const PageStorageKey('1'),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 217,
                  ),
                  itemCount: 15,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PracticeDetailPage(
                                  model: JustDetailModel(image: cstmImage),
                                ),
                              ),
                            );
                          },
                          child: const _GritViewItem(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _GritViewItem extends StatefulWidget {
  const _GritViewItem({Key? key}) : super(key: key);

  @override
  __GritViewItemState createState() => __GritViewItemState();
}

class __GritViewItemState extends State<_GritViewItem> {
  late double heartPositionY;

  @override
  void initState() {
    super.initState();
    heartPositionY = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                CachedImageWidget(image: cstmImage),
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

                          Future.delayed(const Duration(milliseconds: 800), () {
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
              ],
            ),
          ),
          const Spacer(flex: 3),
          Text(
            '4-7-8 Breathing',
            style: const TextStyle(
              color: Color(0xFF092A35),
              fontSize: 15,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              height: 0.09,
            ),
            textScaleFactor: FontSizer.textScaleFactor(context),
          ),
          const Spacer(flex: 2),
          Text(
            '5 Minutes',
            style: const TextStyle(
              color: Color(0xFF4F707B),
              fontSize: 12,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              height: 0.13,
            ),
            textScaleFactor: FontSizer.textScaleFactor(context),
          ),
        ],
      ),
    );
  }
}
