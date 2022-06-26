import 'package:flashcards_app/app.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/frontend/card_display.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flashcards_app/src/frontend/screen.dart';
import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends Screen<List<MetaCard>> {
  final List<MetaCard> metaCards;
  final FlipDirection? flipDirection;

  /// constructor constructs
  const ReviewScreen(this.metaCards, {super.key, this.flipDirection});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ScreenState<ReviewScreen, List<MetaCard>> {
  // view state fields
  FlipPosition flipPosition = FlipPosition.unflipped;

  // review fields
  final List<ReviewCard> done = [];
  final List<ReviewCard> notDone = [];

  @override
  void initState() {
    // add all cards to table with flip direction
    // If flip direction not given, add all cards both ways
    if (widget.flipDirection != FlipDirection.front2back) {
      notDone.addAll(
        widget.metaCards
            .map((metaCard) => ReviewCard(metaCard, FlipDirection.back2front)),
      );
    }
    if (widget.flipDirection != FlipDirection.back2front) {
      notDone.addAll(
        widget.metaCards
            .map((metaCard) => ReviewCard(metaCard, FlipDirection.front2back)),
      );
    }
    notDone.shuffle();
    super.initState();
  }

  /// test function
  void test(bool Function() f) {}

  /// makes all modifications to the cards and returns them with pop
  Future back() => lock(() async {
        // ask for permission
        bool? hasPermission = notDone.isEmpty ||
            (await Dialogs.permission(
                  "Are you sure you want to quit reviewing?\nYou haven't seen all of the cards yet.",
                ) ??
                false);
        if (hasPermission != true) {
          return;
        }
        if (mounted) {
          return pop([]);
        }
      });

  @override
  Scaffold buildScreen(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: BackButton(
        onPressed: back,
      ), // TextButton(onPressed: back, child: Text("back")),
      automaticallyImplyLeading: false,
      title: const Text("Review"),
    ),
    body: Util.todo,
    bottomNavigationBar: Util.todo,
  );
}

class ReviewCard {
  bool? gotCorrect;
  final MetaCard metaCard;
  final FlipDirection flipDirection;
  ReviewCard(this.metaCard, this.flipDirection);
}
