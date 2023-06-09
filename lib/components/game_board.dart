import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/player_info.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/components/player_pile.dart';

import '../deck_piles/deck_pile_eleven.dart';
import '../deck_piles/deck_pile_twelve.dart';
import '../deck_piles/deck_pile_sixteen.dart';
import '../deck_piles/deck_pile_seventeen.dart';
import '../deck_piles/deck_pile_eighteen.dart';
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

                      //Main player dashboard(Left)

                      Container(
                        height: double.infinity,
                        width: 340,
                        color: Colors.black,
                        child: Column(
                          children: [

                            //Game telemetry

                            Expanded(child: Container(color: Colors.blueAccent)),

                            // End turn button

                            Container(
                              height: 30,
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (model.turn.currentPlayer == model.players[0])
                                    ElevatedButton(
                                        onPressed: model.hasPlayed
                                            ? () {
                                          model.endTurn();
                                        }
                                            : null,
                                        child: const Text("End Turn")),
                                ],
                              ),
                            ),

                            // Players hand

                            Container(
                              height: 115,
                              width: double.infinity,
                              child: CardList(
                                player: model.players[0],
                                onPlayCard: (CardModel card) {
                                  model.holdCard(
                                      player: model.turn.currentPlayer,
                                      card: card);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: Column(
                            children: [

                              //Top player home section

                              Container(
                                height: 105.5,
                                width: double.infinity,
                                color: Colors.red,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // print("turn: ${model.turn.currentPlayer}, card: ${model.cardToPlay}");
                                          model.playCardHuman(
                                              player: model.turn.currentPlayer);
                                        },
                                        child: DeckPileTwo(
                                          cards: model.discards,
                                        ),
                                      ),
                                    ]),
                              ),

                              //Left player home section
                              Expanded(
                                  child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: double.infinity,
                                    color: Colors.yellowAccent,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        DeckPileThree(
                                          cards: model.discards,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Deck piles
                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          //Column 1
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DeckPileFive(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileEighteen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileSeventeen(
                                                cards: model.discards,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),

                                          //Column 2
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DeckPileTen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileSixteen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileEleven(
                                                cards: model.discards,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),

                                          //Column 3
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DeckPileEleven(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileTwelve(
                                                cards: model.discards,
                                              )
                                            ],
                                          ),
                                          const SizedBox(width: 20),

                                          //Column 4
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DeckPileFourteen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileThirteen(
                                                cards: model.discards,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),

                                          //Column 5
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DeckPileFifteen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileSixteen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileSeventeen(
                                                cards: model.discards,
                                              )
                                            ],
                                          ),
                                          const SizedBox(width: 20),

                                          //Column 6
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DeckPileTwenty(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileNineteen(
                                                cards: model.discards,
                                              ),
                                              const SizedBox(height: 20),
                                              DeckPileEighteen(
                                                cards: model.discards,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                        ],
                                      )
                                  ),

                                  //Right player home section
                                  Container(
                                    width: 80,
                                    height: double.infinity,
                                    color: Colors.yellowAccent,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        DeckPileFour(
                                          cards: model.discards,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),

                              //Bottom player home section
                              Container(
                                height: 105.5,
                                width: double.infinity,
                                color: Colors.red,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // print("turn: ${model.turn.currentPlayer}, card: ${model.cardToPlay}");
                                          model.playCardHuman(
                                              player: model.turn.currentPlayer);
                                        },
                                        child: DeckPileOne(
                                          cards: model.discards,
                                        ),
                                      ),
                                    ]),
                              ),
                              // if (model.bottomWidget != null)
                              //   model.bottomWidget!
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
