import 'package:flutter/material.dart';
import 'package:street_casino/services/deck_service.dart';

import '../components/game_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
    tempFunc();
  }

  void tempFunc() async {
    final service = DeckService();

    service.newDeck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Game'),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'New Game',
                style: TextStyle(color: Colors.white),
              )
          ),
        ],
      ),
      body: const GameBoard(),
    );
  }
}