import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// extension for card percents
extension CardScore on double {
  static final NumberFormat _percentPattern = NumberFormat.percentPattern();
  String formatPercent() => _percentPattern.format(this);

  /// format a percent
  /// get the percent's color
  Color get color => HSVColor.lerp(
        HSVColor.fromColor(Colors.red),
        HSVColor.fromColor(Colors.green),
        this,
      )!
          .toColor();
}