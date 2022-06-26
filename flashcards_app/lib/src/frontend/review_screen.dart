import 'package:flashcards_app/app.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/frontend/card_display.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReviewScreen extends StatefulWidget {
  final List<MetaCard> metaCards;
  final FlipDirection? flipDirection;

  /// constructor constructs
  const ReviewScreen(this.metaCards, {super.key, this.flipDirection});

  /// get the route for the review screen
  static MaterialPageRoute<List<MetaCard>> route(
    List<MetaCard> metaCards, {
    FlipDirection? flipDirection,
  }) =>
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          metaCards,
          flipDirection: flipDirection,
        ),
      );

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // view state fields
  int disabled = 0;
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

  /// next card

  /// function that locks the ui while performing operations
  Future<T> _action<T>(Future<T> Function() f) async {
    setState(() {
      disabled++;
    });
    return f().catchError((e) {
      Dialogs.alert(e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  /// makes all modifications to the cards and returns them with pop
  Future back() => _action(() async {
        // bool? hasPermission = notDone.isEmpty ||
        //     (await Dialogs.permission(
        //           "Are you sure you want to quit reviewing?\nYou haven't seen all of the cards yet.",
        //         ) ??
        //         false);
        // if (hasPermission != true) {
        //   return false;
        // }
        if (mounted) {
          return Navigator.pop<List<MetaCard>>(context,[]);
        }
        
      });

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: disabled > 0,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: back,), // TextButton(onPressed: back, child: Text("back")),
            automaticallyImplyLeading: false,
            title: const Text("Review"),
          ),
          body: Util.todo,
          bottomNavigationBar: Util.todo,
        ),
      );
}

class ReviewCard {
  bool? gotCorrect;
  final MetaCard metaCard;
  final FlipDirection flipDirection;
  ReviewCard(this.metaCard, this.flipDirection);
}
