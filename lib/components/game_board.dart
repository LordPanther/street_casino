// import 'package:flutter/material.dart';
//
// import 'card_list.dart';
//
// class FourPlayerCardGameLayout extends StatelessWidget {
//   const FourPlayerCardGameLayout({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Top player
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: CardList(
//               player: model.players[1],
//             ),
//           ),
//
//           // Bottom player
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       if (model.turn.currentPlayer == model.players[0])
//                         ElevatedButton(
//                             onPressed: model.canEndTurn
//                                 ? () {
//                               model.endTurn();
//                             } : null,
//                             child: const Text("End Turn")
//                         )
//                     ],
//                   ),
//                 ),
//                 CardList(
//                   player: model.players[0],
//                   onPlayCard: (CardModel card) {
//                     model.playCard(player: model.players[0], card: card);
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // Left player
//           Positioned(
//             top: MediaQuery.of(context).size.height / 4,
//             bottom: MediaQuery.of(context).size.height / 4,
//             left: 0,
//             child: Container(
//               width: MediaQuery.of(context).size.width / 4,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: CardList(
//                   player: model.players[2],
//                 ),
//               ),
//             ),
//           ),
//
//           // Right player
//           Positioned(
//             top: MediaQuery.of(context).size.height / 4,
//             bottom: MediaQuery.of(context).size.height / 4,
//             right: 0,
//             child: Container(
//               width: MediaQuery.of(context).size.width / 4,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: CardList(
//                   player: model.players[3],
//                 ),
//               ),
//             ),
//           ),
//
//           // Center to play
//           Align(
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     GestureDetector(
//                         onTap: () async {
//                           await model.drawCards(model.turn.currentPlayer);
//                         },
//                         child: DeckPile(
//                             remaining: model.currentDeck!.remaining
//                         )
//                     ),
//                     const SizedBox(width: 8.0),
//                     DiscardPile(cards: model.discards)
//                   ],
//                 ),
//                 if (model.bottomWidget != null) model.bottomWidget!
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/player_info.dart';
import 'package:street_casino/components/player_model.dart';

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

                            if (model.turn.currentPlayer == model.players[0])
                              ElevatedButton(
                                  onPressed: model.canEndTurn
                                      ? () {
                                          model.endTurn();
                                        }
                                      : null,
                                  child: const Text("End Turn")),

                            // Players hand

                            CardList(
                              player: model.players[0],
                              onPlayCard: (CardModel card) {
                                model.playCard(
                                    player: model.players[0], card: card);
                              },
                            )
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

                              DiscardPile(cards: model.discards),

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
