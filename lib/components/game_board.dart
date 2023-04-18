import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/card_list.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/components/playing_card.dart';
import 'package:street_casino/models/card_model.dart';

import '../providers/game_provider.dart';
import 'deck_pile.dart';

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
                    child: GestureDetector(
                      onTap: () async {
                        await model.drawCards(model.players.first);
                      },
                        child: DeckPile(
                            remaining: model.currentDeck!.remaining
                        )
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CardList(
                      player: model.players[0],
                    ),
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
