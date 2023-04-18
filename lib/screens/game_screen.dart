import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/providers/game_provider.dart';
import 'package:street_casino/providers/street_casino_game_provider.dart';
import 'package:street_casino/services/deck_service.dart';

import '../components/game_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  late final StreetCasinoGameProvider _gameProvider;

  @override
  void initState() {
    _gameProvider = Provider.of<StreetCasinoGameProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Game'),
        actions: [
          TextButton(
              onPressed: () async {
                final players = [
                  PlayerModel(name: "Lindani", isHuman: true),
                  PlayerModel(name: "Bot", isHuman: false)
                ];

                await _gameProvider.newGame(players);
              },
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
