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
  int get numReveiwCards =>
      int.tryParse(_cardsPerReviewController.text) ??
      Deck.defaultCardsPerReview;

  // controllers
  final TextEditingController _cardsPerReviewController =
      TextEditingController(text: Deck.defaultCardsPerReview.toString());

  /// get the screen
  _DeckDashboardScreenState get screen => widget.screen;

  @override
  void initState() {
    _cardsPerReviewController.text = widget.deckDao.cardsPerReview.toString();
    _cardsPerReviewController.addListener(() => setState(() {
          widget.deckDao.cardsPerReview =
              int.tryParse(_cardsPerReviewController.text) ??
                  Deck.defaultCardsPerReview;
        }));
    super.initState();
  }

  @override
  void dispose() {
    _cardsPerReviewController.dispose();
    super.dispose();
  }

  /// function called to start reviewing cards
  _review() => screen.lock(() async => screen
          .pushRoute(
        ReviewScreen(
                widget.deckDao.pickCards(
                  PickCardsAlgo.lowestWeights(),
                  numCards: numReveiwCards,
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
                  child: const Text("Review"),
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
                        controller: _cardsPerReviewController,
                        decoration: Util.textInputDecoration,
                        keyboardType: TextInputType.number,
                        inputFormatters: [Util.numberInputFormatter],
                      ),
                    ),
                  ]),
                  const Divider(),
                ]),
          ),
        ],
      );
}
