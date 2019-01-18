import 'package:flutter/material.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/card_stack.dart';
import '../../models/match.dart';
import '../../models/profile.dart';
import '../../services/match_engine.dart';

class MainController extends StatefulWidget {

  @override
  _MainControllerState createState() => _MainControllerState();

}

class _MainControllerState extends State<MainController> {

  final MatchEngine matchEngine = MatchEngine (
    matches: demoProfiles.map((Profile profile) => Match(profile: profile)).toList()
  );

  Widget _buildAppBar() {
    return AppBar (
      centerTitle: true,
      title: Icon (
        Icons.whatshot,
        size: 30.0,
        color: Colors.red,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton (
        icon: Icon(
          Icons.person,
          color: Colors.grey,
          size: 40.0,
        ),
        onPressed: () => print('y'),
      ),
      actions: <Widget> [
        IconButton (
          icon: Icon(
            Icons.chat_bubble,
            color: Colors.grey,
            size: 40.0,
          ),
          onPressed: () => print('y'),
        )
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar (
      color: Colors.transparent,
      elevation: 0.0,
      child: Padding (
        padding: EdgeInsets.all(16.0),
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            RoundIconButton.small (
              icon: Icons.refresh,
              iconColor: Colors.orange,
              onPressed: () {
                
              },
            ),
            RoundIconButton.large (
              icon: Icons.clear,
              iconColor: Colors.red,
              onPressed: () {
                matchEngine.currentMatch.nope();
              },
            ),
            RoundIconButton.small (
              icon: Icons.star,
              iconColor: Colors.blue,
              onPressed: () {
                matchEngine.currentMatch.superLike();
              },
            ),
            RoundIconButton.large (
              icon: Icons.favorite,
              iconColor: Colors.green,
              onPressed: () {
                matchEngine.currentMatch.like();
              },
            ),
            RoundIconButton.small (
              icon: Icons.show_chart,
              iconColor: Colors.purple,
              onPressed: () {
                
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: _buildAppBar(),
      body: CardStack (
        matchEngine: matchEngine
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

}