library flashcards_app.frontend.visual_utils;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class Util {
  static Widget wheel = const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );

  static Widget todo = const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: Text("<To Do>")),
  );

  static InputDecoration searchDecoration = const InputDecoration(
    prefixIcon: Icon(Icons.search),
    hintText: "Search",
    filled: true,
    border: OutlineInputBorder(),
    isDense: true,
  );

  static Widget multilineTextField(TextEditingController? controller) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        expands: true,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          filled: true,
          border: OutlineInputBorder(),
          isDense: true,
        ),
      );

  /// format a percent
  static final NumberFormat _percentPattern = NumberFormat.percentPattern();
  static String formatPercent(double value) => _percentPattern.format(value);

  // standard border radius
  static final BorderRadius borderRadius = BorderRadius.circular(4.0);
}
