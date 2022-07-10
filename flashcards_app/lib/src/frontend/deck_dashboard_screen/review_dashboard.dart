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
  int get _numReveiwCards => int.tryParse(cardsPerReviewController.text) ?? 0;

  // controllers
  TextEditingController cardsPerReviewController = TextEditingController(text: "0");

  /// get the screen
  _DeckDashboardScreenState get screen => widget.screen;

  /// function called to start reviewing cards
  _review() => screen.lock(() async => screen
          .pushRoute(
        ReviewScreen(
                widget.deckDao.pickCards(
                  PickCardsAlgo.lowestWeights(),
                  numCards: _numReveiwCards,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // number of cards to review
                  Row(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Cards per Review:"),
                    ),
                    Expanded(
                        child: TextFormField(
                          controller: cardsPerReviewController,
                          decoration: Util.textInputDecoration,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            Util.numberInputFormatter
                          ],
                        )),
                  ]),
                  const Divider(),
                ]),
          ),
        ],
      );
}
