import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/features/practice/data/model/just_model.dart';
import 'package:meditation/features/practice/data/model/position_data_model.dart';
import 'package:meditation/features/practice/presentation/widgets/cached_image_widget.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/mega_text_animation.dart';
import 'package:meditation/features/practice/presentation/widgets/play_button.dart';
import 'package:meditation/features/practice/presentation/widgets/player_timer.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/spaces.dart';
import 'package:rxdart/rxdart.dart';

T? reAroGetAl<T>(T? value) => value;

class PracticeDetailPage extends StatefulWidget {
  const PracticeDetailPage({super.key, required this.model});
  final JustDetailModel model;

  @override
  State<PracticeDetailPage> createState() => _PracticeDetailPageState();
}

class _PracticeDetailPageState extends State<PracticeDetailPage> {
  final GlobalKey<__PlayerBodyState> _childKey = GlobalKey();
  bool vol = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            AppImages.arrowIcon,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              final childState = _childKey.currentState;
              childState?.setVolume(vol ? 1 : 0);
              vol = !vol;
              setState(() {});
            },
            child: Image.asset(
              AppImages.valumeIcon,
              scale: 4,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          CachedImageWidget(
            image: widget.model.image,
            radius: 0,
          ),
          Center(
            child: _PlayerBody(
              key: _childKey,
            ),
          ),
        ],
      ),
    );
  }
}

final class _PlayerBody extends StatefulWidget {
  const _PlayerBody({Key? key}) : super(key: key);

  @override
  State<_PlayerBody> createState() => __PlayerBodyState();
}

class __PlayerBodyState extends State<_PlayerBody> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    reAroGetAl(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            "https://filesamples.com/samples/audio/mp3/sample4.mp3",
          ),
        ),
      );
    } catch (e) {
      print("Error loading audio source: $e");
    }
    _player.play();
  }

  @override
  void dispose() {
    reAroGetAl(WidgetsBinding.instance)!.removeObserver(this);

    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  void setVolume(double value) => _player.setVolume(value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
        const SizedBox(height: 24),
        PlayButtons(_player),
        const SizedBox(height: 70),
        MegaTweenAnimations.appearWidget(
          duration: const Duration(milliseconds: 800),
          child: SizedBox(
            height: 50,
            width: context.width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _player.pause();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.color658525,
              ),
              child: Text(
                'Stop Practice',
                style: AppTextStylesMeditation.s18Wbold(color: AppColors.white),
                textScaleFactor: FontSizer.textScaleFactor(context),
              ),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
