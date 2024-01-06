import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/practice/data/model/position_data_model.dart';
import 'package:meditation/features/practice/data/model/practice_model.dart';
import 'package:meditation/features/practice/presentation/child_pages/page_view_item.dart';
import 'package:meditation/features/practice/presentation/widgets/app_loading.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/mega_text_animation.dart';
import 'package:meditation/features/practice/presentation/widgets/player_timer.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/spaces.dart';
import 'package:rxdart/rxdart.dart';

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
  late AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    getPremium();
    super.initState();
  }

  late final PageController controller =
      PageController(initialPage: widget.currIndex);
  late int pageIndex = widget.currIndex;
  bool isLoad = true;
  bool isPlay = true;
  bool byPremium = false;

  getPremium() async {
    byPremium = await PremiumMetitation.getPremium();
    setState(() {});
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics(),
            ),
            itemCount: widget.model.length,
            controller: controller,
            onPageChanged: (value) {
              pageIndex = value;
            },
            itemBuilder: (context, index) => PageViewItem(
              player: player,
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
            child: Column(
              children: [
                if (!isLoad)
                  StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return PlayerTimeWidget(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                      );
                    },
                  ),
                const SizedBox(height: 22),
                Row(
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
                        ? const AppLoadingWidget(
                            backgroundColor: AppColors.white,
                          )
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
                        if (widget.model[pageIndex + 1].premium && !byPremium) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const BottomNavigatorScreen(currindex: 3),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return child;
                              },
                              transitionDuration: const Duration(
                                seconds: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        } else if (pageIndex != widget.model.length - 1) {
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

String formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);

  String hours = (duration.inHours % 24).toString().padLeft(2, '0');
  String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  String secondsStr = (duration.inSeconds % 60).toString().padLeft(2, '0');

  if (duration.inHours > 0) {
    return '$hours:$minutes:$secondsStr';
  } else {
    return '$minutes:$secondsStr';
  }
}
