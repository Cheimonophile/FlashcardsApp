library flashcards_app.app;

import 'package:flashcards_app/src/frontend/app_home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final _navKey = GlobalKey<NavigatorState>();
  static BuildContext get context => _navKey.currentContext!;

  static void run() => runApp(const App());


  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        navigatorKey: _navKey,
        home: const AppHome()
      );
}