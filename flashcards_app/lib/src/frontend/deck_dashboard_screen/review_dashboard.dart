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
  int _TempNumReveiwCards = 20;

  /// get the screen
  _DeckDashboardScreenState get screen => widget.screen;

  /// function called to start reviewing cards
  _review() => screen.lock(() async => screen
          .pushRoute(
        ReviewScreen(
                widget.deckDao.pickCards(
                  PickCardsAlgo.lowestWeights(),
                  numCards: _TempNumReveiwCards,
                  flipDirection: FlipDirection.front2back,
                ),
                algo: ProcessReviewAlgo.inverseProportionNumberSeen())
            .route,
      )
          .then((reviewResult) {
        if (reviewResult == null) {
          return;
        }
        widget.deckDao.updateCards(reviewResult);
      }));

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // side bar
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                  onPressed: _review,
                  child: Text("Review"),
                )
              ],
            ),
          ),
          const VerticalDivider(),
          // main area
          Expanded(
            child: Column(
              children: testCards
                  .map((testCard) => Row(children: [
                        Expanded(child: Text(testCard.metaCard.card.frontText)),
                        Expanded(child: Text(testCard.metaCard.card.backText)),
                        Text(testCard.metaCard.card.front2backScore
                            .toString()),
                        const VerticalDivider(),
                        Text(testCard.metaCard.card.back2frontScore
                            .toString()),
                      ]))
                  .toList(),
            ),
          ),
        ],
      );
}
