
library flashcards_app.frontend.visual_utils;


import 'package:flutter/material.dart';

abstract class VisUtil {

  Widget wheel() => const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );
}