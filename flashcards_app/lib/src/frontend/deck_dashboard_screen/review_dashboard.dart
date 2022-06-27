part of flashcards_app.frontend.deck_dashboard_screen;

class _ReviewDashboard extends StatefulWidget {
  const _ReviewDashboard(this.screen, this.deckDao, {Key? key})
      : super(key: key);

  @override
  final _DeckDashboardScreenState screen;
  final DeckDao deckDao;

  @override
  State<_ReviewDashboard> createState() => _ReviewDashboardState();
}

class _ReviewDashboardState extends State<_ReviewDashboard> {
  List<ReviewCard> testCards = [];

  /// get the screen∏
  _DeckDashboardScreenState get screen => widget.screen;

  /// function called to start reviewing cards
  review() => screen.lock(
        () async => testCards = widget.deckDao.pickCards(
          PickCardsAlgo.lowestWeights,
          numCards: 1,
          flipDirection: FlipDirection.front2back,
        ),
        // () => screen
        //     .pushRoute(ReviewScreen(widget.deckDao.pickCards(
        //       PickCardsAlgo.lowestWeights,
        //       numCards: 1,
        //       flipDirection: FlipDirection.front2back,
        //     )).route)
        //     .then((reviewResult) => setState(() {
        //           testCards = [];
        //         }))
        //     .then((reviewResult) => setState(() {
        //           testCards = widget.deckDao.pickCards(
        //             PickCardsAlgo.lowestWeights,
        //             numCards: 1,
        //             flipDirection: FlipDirection.front2back,
        //           );
        //         })),
      );

  /// buttons for command window
  late final Map<String, Function()> buttons = {
    "Review": review,
  };

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // side bar
          IntrinsicWidth(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buttons.entries
                    .map((entry) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: OutlinedButton(
                            onPressed: entry.value,
                            child: Text(entry.key),
                          ),
                        ))
                    .toList()),
          ),
          const VerticalDivider(),
          // main area
          Expanded(
            child: testCards.isEmpty
                ? Util.wheel
                : CardDisplay(
                    testCards[0].metaCard.card,
                    flipDirection: testCards[0].flipDirection,
                    flipPosition: FlipPosition.unflipped,
                  ),
          ),
        ],
      );
}
