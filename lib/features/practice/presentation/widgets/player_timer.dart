import 'package:flutter/material.dart';
import 'package:meditation/features/practice/presentation/widgets/font_sizer.dart';
import 'package:meditation/features/practice/presentation/widgets/mega_text_animation.dart';

class PlayerTimeWidget extends StatefulWidget {
  const PlayerTimeWidget({
    super.key,
    required this.duration,
    required this.position,
  });

  final Duration duration;
  final Duration position;
  @override
  State<PlayerTimeWidget> createState() => _PlayerTimeWidgetState();
}

class _PlayerTimeWidgetState extends State<PlayerTimeWidget> {
  Duration get _remaining => widget.duration - widget.position;

  @override
  Widget build(BuildContext context) {
    return MegaTweenAnimations.appearWidget(
      duration: const Duration(milliseconds: 400),
      child: Text(
        RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("$_remaining")
                ?.group(1) ??
            '$_remaining',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 46,
          fontFamily: 'Syne',
          fontWeight: FontWeight.w700,
          height: 0.02,
        ),
        textScaleFactor: FontSizer.textScaleFactor(context),
      ),
    );
  }
}
