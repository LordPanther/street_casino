// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:street_casino/components/card_list.dart';
// // import 'package:street_casino/components/discard_pile.dart';
// import 'package:street_casino/components/player_info.dart';
// import 'package:street_casino/components/player_model.dart';
// import 'package:street_casino/models/card_model.dart';

// import '../providers/street_casino_game_provider.dart';
// import 'deck_pile.dart';

// class GameBoard extends StatelessWidget {
//   const GameBoard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StreetCasinoGameProvider>(
//       builder: (context, model, child) {
//         return model.currentDeck != null
//             ? Scaffold(
//                 body: Column(
//                 children: [
//                   //Player info at top

//                   PlayerInfo(turn: model.turn),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Middle Pile. Deck and Discard

//                         Align(
//                           alignment: Alignment.center,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
                                  
//                                   const SizedBox(width: 8.0),
//                                   // DiscardPile(cards: model.discards)
//                                 ],
//                               ),
                              
//                             ],
//                           ),
//                         ),

//                         // Player pile

//                         Align(
//                           alignment: Alignment.center,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
                                    
//                                   ],
//                                 ),
//                               ),
//                               ,
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ))

// //  If card model = null return New Game

//             : 
//       },
//     );
//   }
// }
