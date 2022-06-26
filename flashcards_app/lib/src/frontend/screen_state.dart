import 'dart:async';

import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// class includes a bunch of would-be boilerplate for 
abstract class ScreenState<SW extends StatefulWidget> extends State<SW> {

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
