import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/card_list.dart';
import 'package:street_casino/components/discard_pile.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/components/playing_card.dart';
import 'package:street_casino/models/card_model.dart';

import '../providers/game_provider.dart';
import '../providers/street_casino_game_provider.dart';
import 'deck_pile.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StreetCasinoGameProvider>(
      builder: (context, model, child) {
        return model.currentDeck != null
            ? Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await model.drawCards(model.turn.currentPlayer);
                          },
                            child: DeckPile(
                                remaining: model.currentDeck!.remaining
                            )
                        ),
                        const SizedBox(width: 8.0),
                        DiscardPile(cards: model.discards)
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: CardList(
                      player: model.players[1],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (model.turn.currentPlayer == model.players[0])
                                ElevatedButton(
                                  onPressed: model.canEndTurn
                                    ? () {
                                      model.endTurn();
                                    } : null,
                                    child: const Text("End Turn")
                                )
                            ],
                          ),
                        ),
                        CardList(
                          player: model.players[0],
                          onPlayCard: (CardModel card) {
                            model.playCard(player: model.players[0], card: card);
                          },
                        ),
                      ],
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
