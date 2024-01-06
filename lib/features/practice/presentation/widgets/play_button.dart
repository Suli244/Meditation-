import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation/core/icons/my_flutter_app_icons.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/practice/data/model/just_model.dart';
import 'package:meditation/features/practice/presentation/widgets/app_loading.dart';
import 'package:meditation/features/practice/presentation/widgets/mega_text_animation.dart';
import 'package:meditation/theme/app_colors.dart';

class PlayButtons extends StatelessWidget {
  final AudioPlayer player;
  const PlayButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => MegaTweenAnimations.appearWidget(
            duration: const Duration(milliseconds: 600),
            child: IconButton(
              icon: const Icon(
                Icons.skip_previous,
                color: AppColors.white,
              ),
              onPressed: player.hasPrevious ? player.seekToPrevious : null,
              iconSize: 44.0,
            ),
          ),
        ),
        const SizedBox(width: 30),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return const AppLoadingWidget(
                height: 58,
                width: 58,
                backgroundColor: AppColors.white,
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: AppColors.white,
                ),
                iconSize: 44.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(
                  MyFlutterApp.pauseicon,
                  color: AppColors.white,
                ),
                iconSize: 44.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: AppColors.white,
                ),
                iconSize: 44.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        const SizedBox(width: 30),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.sequence.isEmpty ?? true) {
              return const SizedBox();
            }
            final metadata = state!.currentSource!.tag as MusicNextModel;
            return MegaTweenAnimations.appearWidget(
              duration: const Duration(milliseconds: 600),
              child: IconButton(
                icon: const Icon(
                  MyFlutterApp.skipnext,
                  color: AppColors.white,
                ),
                iconSize: 44.0,
                onPressed: () {
                  if (player.hasNext && metadata.isPremium) {
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
                        ),
                      ),
                      (route) => false,
                    );
                  } else {
                    player.seekToNext();
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
