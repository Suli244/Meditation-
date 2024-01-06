import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/features/practice/data/model/practice_model.dart';
import 'package:meditation/features/practice/presentation/child_pages/page_view_item.dart';
import 'package:meditation/features/practice/presentation/widgets/app_loading.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/mega_text_animation.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/spaces.dart';

class MusicDetailPage extends StatefulWidget {
  const MusicDetailPage({
    super.key,
    this.currIndex = 0,
    required this.model,
  });
  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
  final int currIndex;
  final List<PracticeModel> model;
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  late final PageController controller =
      PageController(initialPage: widget.currIndex);
  late int pageIndex = widget.currIndex;
  bool isLoad = true;
  bool isPlay = true;
  late AudioPlayer player;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: widget.model.length,
            controller: controller,
            onPageChanged: (value) {
              pageIndex = value;
            },
            itemBuilder: (context, index) => PageViewItem(
              model: widget.model[index],
              onLoad: (bool isLoadFrom, AudioPlayer playerFrom) {
                setState(() {
                  isLoad = isLoadFrom;
                  player = playerFrom;
                });
              },
            ),
          ),
          Positioned(
            top: 20,
            left: 16,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  AppImages.arrowIcon,
                  height: 40.h,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 112,
            right: 86.w,
            left: 86.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset(
                    AppImages.skipPreviousIcon,
                    height: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (pageIndex != 0) {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                      setState(() {
                        isLoad = true;
                      });
                    }
                  },
                ),
                isLoad
                    ? const AppLoadingWidget()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlay = !isPlay;
                            player.pause();
                          });
                          if (!isPlay) {
                            player.pause();
                          } else {
                            player.play();
                          }
                        },
                        child: isPlay
                            ? Image.asset(
                                AppImages.pauseIcon,
                                height: 25,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                      ),
                IconButton(
                  onPressed: () {
                    if (pageIndex != widget.model.length - 1) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                      setState(() {
                        isLoad = true;
                      });
                    }
                  },
                  icon: Image.asset(
                    AppImages.skipNextIcon,
                    height: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: SafeArea(
              child: MegaTweenAnimations.appearWidget(
                duration: const Duration(milliseconds: 800),
                child: SizedBox(
                  height: 50,
                  width: context.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.color658525,
                    ),
                    child: Text(
                      'Stop Practice',
                      style: AppTextStylesMeditation.s18Wbold(
                        color: AppColors.white,
                      ),
                      textScaleFactor: FontSizer.textScaleFactor(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
