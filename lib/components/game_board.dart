import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/player_info.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/components/player_pile.dart';

import '../models/card_model.dart';
import '../providers/street_casino_game_provider.dart';
import 'card_list.dart';
import 'discard_pile.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StreetCasinoGameProvider>(builder: (context, model, child) {
      return model.currentDeck != null
          ? Scaffold(
              body: Column(
              children: [
                //Player turn info

                PlayerInfo(turn: model.turn),

                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 400,
                        color: Colors.black,
                        child: Column(
                          children: [
                            // End turn button

                            // if (model.turn.currentPlayer == model.players[0])
                            ElevatedButton(
                                onPressed: () {
                                  model.endTurn();
                                },
                                child: const Text("End Turn")),

                            // Players hand

                            CardList(
                              player: model.players[0],
                              onPlayCard: (CardModel card) {
                                model.holdCard(
                                    player: model.turn.currentPlayer,
                                    card: card);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Floor

                              // DiscardPile(cards: model.discards),
                              GestureDetector(
                                onTap: () {
                                  // print("turn: ${model.turn.currentPlayer}, card: ${model.cardToPlay}");
                                  model.playCardHuman(
                                      player: model.turn.currentPlayer);
                                },
                                child: PlayerPiles(
                                  cards: model.discards,
                                ),
                              ),

                              if (model.bottomWidget != null)
                                model.bottomWidget!
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))

          // New game function

          : Center(
              child: TextButton(
              child: const Text("New Game?"),
              onPressed: () {
                final players = [
                  PlayerModel(name: "Lindani", isHuman: true),
                  PlayerModel(name: "Bot A", isHuman: false),
                  PlayerModel(name: "Bot B", isHuman: false),
                  PlayerModel(name: "Bot C", isHuman: false)
                ];
                model.newGame(players);
              },
            ));
    });
  }
}
