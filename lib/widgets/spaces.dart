import 'package:flutter/material.dart';

extension GetSizes on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
  bool get hasBottomPadding => MediaQuery.of(this).padding.bottom > 0;
}
