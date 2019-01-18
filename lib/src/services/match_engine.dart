import 'package:flutter/widgets.dart' show ChangeNotifier;
import '../models/match.dart';
import '../models/decision.dart';

class MatchEngine extends ChangeNotifier {

  final List<Match> _matches;
  int _currentMatchIndex;
  int _nextMatchIndex;

  MatchEngine({
    List<Match> matches
  }) : _matches = matches {
    _currentMatchIndex = 0;
    _nextMatchIndex = 1;
  }

  Match get currentMatch => _matches[_currentMatchIndex];
  Match get nextMatch => _matches[_nextMatchIndex];
  
  void cycleMatch() {
    if(currentMatch.decision != Decision.UNDECIDED) {
      currentMatch.reset();

      _currentMatchIndex = _nextMatchIndex;
      _nextMatchIndex = _nextMatchIndex < _matches.length - 1 ? _nextMatchIndex + 1 : 0;
      
      notifyListeners();
    }
  }

}