import 'dart:async';

import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';




abstract class Screen<ScreenReturn> extends StatefulWidget {
  const Screen({super.key});

  /// get the route for the review screen
  MaterialPageRoute<ScreenReturn> get route => MaterialPageRoute(
        builder: (context) => this,
      );
}


/// class includes a bunch of would-be boilerplate for 
abstract class ScreenState<StatefulWidgetType extends StatefulWidget> extends State<StatefulWidgetType> {

  /// function that locks the ui while performing operations
  /// 
  /// also catches exceptions in the operations and alerts the user to them
  int disabled = 0;
  Future<T> lock<T>(Future<T> Function() f) {
    setState(() {
      disabled++;
    });
    return f().catchError((e) {
      Dialogs.alert(e.toString());
    }).whenComplete(() {
      if (mounted) {
        setState(() => disabled--);
      }
    });
  }

  @override
  @nonVirtual
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: disabled > 0,
        child: buildScreen(context), // needs to be scaffold
      );

  /// builds the screen
  Scaffold buildScreen(BuildContext context);
}
