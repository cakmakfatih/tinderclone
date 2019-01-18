import 'package:flutter/material.dart';
import 'draggable_card.dart';
import 'profile_card.dart';
import '../models/match.dart';
import '../models/decision.dart';
import '../models/slide_direction.dart';
import '../services/match_engine.dart';

class CardStack extends StatefulWidget {

  final MatchEngine matchEngine;

  CardStack({
    this.matchEngine
  });

  @override
  _CardStackState createState() => _CardStackState();

}

class _CardStackState extends State<CardStack> {

  Key _frontCard;
  Match _currentMatch;
  double _nextCardScale = 0.9;

  @override
  void initState() {
    super.initState();

    widget.matchEngine.addListener(_onMatchEngineChanged);

    _currentMatch = widget.matchEngine.currentMatch;
    _currentMatch.addListener(_onMatchChanged);

    _frontCard = Key(_currentMatch.profile.name); 
  }

  @override
  void didUpdateWidget(CardStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.matchEngine != oldWidget.matchEngine) {
      oldWidget.matchEngine.removeListener(_onMatchEngineChanged);
      widget.matchEngine.addListener(_onMatchEngineChanged);

      if(_currentMatch != null) {
        _currentMatch.removeListener(_onMatchChanged);
      }

      _currentMatch = widget.matchEngine.currentMatch;
      
      if(_currentMatch != null) {
        _currentMatch.addListener(_onMatchChanged);
      }
    }
  }

  @override
  void dispose() {
    if(_currentMatch != null) {
      _currentMatch.removeListener(_onMatchChanged);
    }

    widget.matchEngine.removeListener(_onMatchEngineChanged);

    super.dispose();
  }

  void _onMatchEngineChanged() {
    setState(() {
      if(_currentMatch != null) {
        _currentMatch.removeListener(_onMatchChanged);
      }

      _currentMatch = widget.matchEngine.currentMatch;

      if(_currentMatch != null) {
        _currentMatch.addListener(_onMatchChanged);
      }

      _frontCard = Key(_currentMatch.profile.name);
    });
  }

  void _onMatchChanged() {
    setState(() {

    });
  }

  Widget _buildBackCard() {
    return Transform (
      transform: Matrix4.identity()..scale(_nextCardScale, _nextCardScale),
      alignment: Alignment.center,
      child: ProfileCard (
        profile: widget.matchEngine.nextMatch.profile
      ),
    );
  }

  Widget _buildFrontCard() {
    return ProfileCard (
      key: _frontCard,
      profile: widget.matchEngine.currentMatch.profile
    );
  }

  SlideDirection _desiredSlideOutDirection() {
    switch(widget.matchEngine.currentMatch.decision) {
      case Decision.NOPE:
        return SlideDirection.LEFT;
      case Decision.LIKE:
        return SlideDirection.RIGHT;
      case Decision.SUPER_LIKE:
        return SlideDirection.UP;
      default:
        return null;
    }
  }

  void _onSlideUpdated(double distance) {
    setState(() {
      _nextCardScale = 0.9 + (0.1 * (distance / 100.0)).clamp(0.0, 0.1);
    });
  }

  void _onSlideOutCompleted(SlideDirection direction) {
    Match currentMatch = widget.matchEngine.currentMatch;

    switch(direction) {
      case SlideDirection.LEFT:
        currentMatch.nope();
        break;
      case SlideDirection.RIGHT:
        currentMatch.like();
        break;
      case SlideDirection.UP:
        currentMatch.superLike();
        break;
    }

    widget.matchEngine.cycleMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Stack (
      children: <Widget> [
        DraggableCard (
          card: _buildBackCard(),
          isDraggable: false,
        ),
        DraggableCard (
          card: _buildFrontCard(),
          slideTo: _desiredSlideOutDirection(),
          onSlideUpdated: _onSlideUpdated,
          onSlideOutCompleted: _onSlideOutCompleted,
        )
      ],
    );
  }

}