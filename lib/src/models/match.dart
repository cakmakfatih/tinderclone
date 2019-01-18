import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'decision.dart';
import 'profile.dart' show Profile;

class Match extends ChangeNotifier {

  final Profile profile;

  Match({
    this.profile
  });

  Decision decision = Decision.UNDECIDED;

  void like() {
    if(decision == Decision.UNDECIDED) {
      decision = Decision.LIKE;
      notifyListeners();
    }
  }

  void nope() {
    if(decision == Decision.UNDECIDED) {
      decision = Decision.NOPE;
      notifyListeners();
    }
  }

  void superLike() {
    if(decision == Decision.UNDECIDED) {
      decision = Decision.SUPER_LIKE;
      notifyListeners();
    }
  }

  void reset() {
    if(decision != Decision.UNDECIDED) {
      decision = Decision.UNDECIDED;
      notifyListeners();
    }
  }

}