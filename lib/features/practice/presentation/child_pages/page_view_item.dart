import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/features/practice/data/model/practice_model.dart';
import 'package:meditation/features/practice/presentation/widgets/cached_image_widget.dart';
import 'package:meditation/theme/app_colors.dart';

class PageViewItem extends StatefulWidget {
  const PageViewItem({
    super.key,
    required this.model,
    required this.onLoad,
    required this.player,
  });
  @override
  State<PageViewItem> createState() => _PageViewItemState();
  final PracticeModel model;
  final AudioPlayer player;
  final Function(bool isLoad, AudioPlayer player) onLoad;
}

class _PageViewItemState extends State<PageViewItem> {
  late AudioPlayer player;
  @override
  void initState() {
    player = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadAudio();
    });
    super.initState();
  }

  Future<void> loadAudio() async {
    try {
      await player.setUrl(widget.model.audio);
      widget.onLoad(false, player);
      await player.play();
    } catch (e) {
      log('data: 1 ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedImageWidget(
          image: widget.model.image,
          radius: 0,
        ),
        Positioned(
          top: 20,
          right: 16,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                if (player.volume == 1) {
                  player.setVolume(0);
                } else {
                  player.setVolume(1);
                }
                setState(() {});
              },
              child: player.volume == 1
                  ? Image.asset(
                      AppImages.valumeIcon,
                      height: 40.h,
                    )
                  : CircleAvatar(
                      radius: 20.h,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.volume_off,
                        color: AppColors.color658525,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }
}
