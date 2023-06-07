import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/providers/street_casino_game_provider.dart';

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
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Card Game'),
      //   actions: [
      //     TextButton(
      //         onPressed: () async {
      //           final players = [
      //             PlayerModel(name: "Lindani", isHuman: true),
      //             PlayerModel(name: "Bot A", isHuman: false),
      //             PlayerModel(name: "Bot B", isHuman: false),
      //             PlayerModel(name: "Bot C", isHuman: false)
      //           ];
      //
      //           await _gameProvider.newGame(players);
      //         },
      //         child: const Text(
      //           'New Game',
      //           style: TextStyle(color: Colors.white),
      //         )
      //     ),
      //   ],
      // ),

      // App Bar disabled temporarily

      body: GameBoard(),
    );
  }
}
