part of flashcards_app.frontend.deck_dashboard_screen;

class _ReviewDashboard extends StatefulWidget {
  const _ReviewDashboard(this.deckDao, {Key? key, required this.whileChange})
      : super(key: key);

  final DeckDao deckDao;
  final Future Function(Future Function()) whileChange;

  @override
  State<_ReviewDashboard> createState() => _ReviewDashboardState();
}

class _ReviewDashboardState extends State<_ReviewDashboard> {
  List<MetaCard> testCards = [];

  /// function called to start reviewing cards
  review() => widget.whileChange(() => Navigator.push(
        context,
        ReviewScreen.route(widget.deckDao.pickCards(
          PickCardsAlgo.lowestWeights,
          numCards: 3,
        )),
      ).then((reviewResult) => setState(() {
            testCards = reviewResult ?? [];
          })));

  /// buttons for command window
  late final Map<String, Function()> buttons = {"Review": review};

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
            child: ListView(
              children: testCards
                  .map((testCard) => Text(
                        _CardRow.formatCardText(testCard.card.frontText),
                        overflow: TextOverflow.ellipsis,
                      ))
                  .toList(),
            ),
          ),
        ],
      );
}
