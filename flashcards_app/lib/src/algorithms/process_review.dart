library flashcards_app.algorithms.process_review;

import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';

class ProcessReviewAlgo {
  static const int newWeightDivisor = 2;

  /// given a reviewCard, applies the results of the review to it's metacard and returns it
  final Function(ReviewCard reviewCard) process;

  // private constructor
  ProcessReviewAlgo._(this.process);

  /// The edits the score of a review card
  factory ProcessReviewAlgo.inverseProportionNumberSeen() =>
      ProcessReviewAlgo._((reviewCard) {
        var oldScore = reviewCard.score;
        var newScore = (oldScore * (newWeightDivisor - 1) + Card.maxScore / reviewCard.timesSeen) / newWeightDivisor;
        reviewCard._score = newScore;
      });
}

/// Type for holding a review card
class ReviewCard {
  int timesSeen = 0;
  final MetaCard metaCard;
  final FlipDirection flipDirection;
  ReviewCard(this.metaCard, this.flipDirection);

  // score accessors abstract card direction
  double get score => flipDirection == FlipDirection.front2back
      ? metaCard.card.front2backScore
      : metaCard.card.back2frontScore;
  set _score(double newScore) => flipDirection == FlipDirection.front2back
      ? metaCard.card = metaCard.card.to(front2backScore: newScore)
      : metaCard.card = metaCard.card.to(front2backScore: newScore);
}
