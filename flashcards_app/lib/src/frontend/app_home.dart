library flashcards_app.frontend.app_home;

import 'package:flashcards_app/src/backend/app_data_access.dart';
import 'package:flashcards_app/src/frontend/deck_selection_screen.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  _AppHomeState() {
    AppDao.init(onLoad: () {
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) => AppDao.ready
      ? const DeckSelectionScreen()
      : const Scaffold(body: Center(child: CircularProgressIndicator()));
}