import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/components/playing_card.dart';
import 'package:street_casino/models/card_model.dart';

import '../providers/game_provider.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, model, child) {
        return model.currentDeck != null
            ? Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text("TEST ${model.currentDeck!.remaining}"),
                  )
                ],
              )
            : Center(
                child: TextButton(
                  child: const Text("New Game?"),
                  onPressed: () {
                    final players = [
                      PlayerModel(name: "Lindani", isHuman: true),
                      PlayerModel(name: "Bot", isHuman: false)
                    ];
                    model.newGame(players);
                  },
                )
              );
      },
    );
  }
}
