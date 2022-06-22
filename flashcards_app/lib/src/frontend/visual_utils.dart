library flashcards_app.frontend.visual_utils;

import 'package:flutter/material.dart';

abstract class VisUtil {
  static Widget wheel = const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );

  static InputDecoration searchDecoration = const InputDecoration(
    prefixIcon: Icon(Icons.search),
    hintText: "Search",
    filled: true,
    border: OutlineInputBorder(),
    isDense: true,
  );

  static InputDecoration multilineDecoration = const InputDecoration(
    filled: true,
    border: OutlineInputBorder(),
    isDense: true,
  );

  static Widget multilineTextField(TextEditingController? controller) => TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: VisUtil.multilineDecoration,
      );
}
