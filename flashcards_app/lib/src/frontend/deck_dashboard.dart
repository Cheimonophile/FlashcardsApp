
library flashcards_app.backend.deck_dashboard;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flashcards_app/src/data/deck.dart';

import 'package:path/path.dart' as p;






class DeckDashboard extends StatefulWidget {
  const DeckDashboard(this.path, this.deck, {super.key});

  final String path;
  final Deck deck;

  @override
  State<DeckDashboard> createState() => _DeckDashboardState();
}

class _DeckDashboardState extends State<DeckDashboard> {

  bool disabled = false;
  
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Scaffold(
        appBar: AppBar(
          title: Text(p.basename(File(widget.path).path))
        )
      )
    );
  }
}