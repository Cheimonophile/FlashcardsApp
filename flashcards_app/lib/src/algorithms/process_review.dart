library flashcards_app.algorithms.process_review;

import 'package:flashcards_app/src/data/card.dart';

class ProcessReviewAlgo {
  static const int newWeightDivisor = 3;

  /// given a reviewCard, applies the results of the review to it's metacard and returns it
  final MetaCard Function(ReviewCard reviewCard) process;

  // private constructor
  ProcessReviewAlgo._(this.process);

  /// The cards score is averaged with the inverse of the number of times the card is seen
  factory ProcessReviewAlgo.inverseProportionNumberSeen() =>
      ProcessReviewAlgo._((reviewCard) {
        var oldScore = reviewCard.score;
        var newScore = (oldScore * (newWeightDivisor - 1) + Card.maxScore / reviewCard.timesSeen) / newWeightDivisor;
        reviewCard.score = newScore;
        return reviewCard.metaCard;
      });
}
