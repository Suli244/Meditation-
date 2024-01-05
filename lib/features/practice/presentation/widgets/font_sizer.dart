import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meditation/widgets/spaces.dart';

final class FontSizer {
  static double textScaleFactor(
    BuildContext context, {
    double maxTextScaleFactor = 2,
  }) {
    double val = (context.width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
