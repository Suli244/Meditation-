import 'package:flutter/material.dart';

/// CountS animation [MegaTweenAnimations]
/// appear animation [MegaTweenAnimations.appearWidget]
/// scales animation [MegaTweenAnimations.scaleWidget]
/// slideS animation [MegaTweenAnimations.slideWidget]
final class MegaTweenAnimations extends StatelessWidget {
  const MegaTweenAnimations({
    super.key,
    this.finish = 1.0,
    this.begin = 0.0,
    this.curve,
    required this.builder,
    this.duration,
    this.child,
  }) : assert(finish != 0, 'Конечная aнимация не должна быть равна к 0');

  /// Animations with Opacity
  factory MegaTweenAnimations.appearWidget({
    double finish = 1.0,
    double begin = 0.0,
    Curve? curve,
    Duration? duration,
    Duration opacityDuration = Duration.zero,
    required Widget child,
  }) =>
      MegaTweenAnimations(
        duration: duration,
        curve: curve,
        begin: begin,
        finish: finish,
        builder: (context, value, builderChild) => AnimatedOpacity(
          opacity: value,
          duration: opacityDuration,
          child: builderChild,
        ),
        child: child,
      );

  /// Animations with Scale
  factory MegaTweenAnimations.scaleWidget({
    double finish = 1.0,
    double begin = 0.0,
    Curve? curve,
    Duration? duration,
    Duration scaleDuration = const Duration(milliseconds: 100),
    required Widget child,
  }) =>
      MegaTweenAnimations(
        duration: duration,
        curve: curve,
        begin: begin,
        finish: finish,
        builder: (context, value, builderChild) => AnimatedScale(
          scale: value,
          duration: scaleDuration,
          child: builderChild,
        ),
        child: child,
      );

  /// Animations with Slide
  factory MegaTweenAnimations.slideWidget({
    double finish = 1.0,
    double begin = 0.0,
    Curve? curve,
    Duration? duration,
    Duration slideDuration = const Duration(milliseconds: 100),
    required Widget child,
    Offset Function(double value)? offsetBuilder,
  }) =>
      MegaTweenAnimations(
        duration: duration,
        curve: curve,
        begin: begin,
        finish: finish,
        builder: (context, value, builderChild) => AnimatedSlide(
          offset:
              offsetBuilder != null ? offsetBuilder(value) : Offset(0, value),
          duration: slideDuration,
          child: builderChild,
        ),
        child: child,
      );

  final double? begin;
  final double? finish;
  final Curve? curve;
  final ValueWidgetBuilder<double> builder;
  final Duration? duration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: begin,
        end: finish,
      ),
      curve: curve ?? Curves.easeIn,
      duration: duration ?? const Duration(seconds: 1),
      builder: builder,
      child: child,
    );
  }
}
