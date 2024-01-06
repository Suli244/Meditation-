import 'package:flutter/material.dart';

final class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    Key? key,
    this.height,
    this.width,
    this.loadingThickness = 4.0,
    this.backgroundColor,
  }) : super(key: key);

  final double? height;
  final double? width;
  final double loadingThickness;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: loadingThickness,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
