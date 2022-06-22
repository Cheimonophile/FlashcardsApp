part of flashcards_app.frontend.deck_dashboard;

class _CardRow extends StatelessWidget {
  const _CardRow(this.metaCard, this.controller, {super.key});

  final MetaCard metaCard;
  final CardsTableController controller;

  /// function called when checkbox is clicked
  onChanged(bool? newValue) {
    if (newValue == true) {
      controller.addSelected({metaCard.index});
    } else {
      controller.removeSelected({metaCard.index});
    }
  }

  /// formats the card text for display in the text box
  String formatCardText(String cardText) => cardText.replaceAll("\n", "...\t");

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // check box
          IntrinsicHeight(
            child: Checkbox(
              value: controller.selected.contains(metaCard.index),
              onChanged: onChanged,
            ),
          ),
          // view and button
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Text(
                        formatCardText(metaCard.card.frontText),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: Text(
                        formatCardText(metaCard.card.backText),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
