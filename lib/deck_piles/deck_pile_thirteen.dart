import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/components/playing_card.dart';
import 'package:street_casino/constants.dart';

import '../models/card_model.dart';
import '../providers/street_casino_game_provider.dart';

class DeckPileThirteen extends StatelessWidget {
  final List<CardModel> cards;
  final double size;

  const DeckPileThirteen({
    Key? key,
    required this.cards,
    this.size = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CARD_WIDTH * size,
      height: CARD_HEIGHT * size,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 2,
        ),
      ),
      child: Stack(
          children: cards
              .map((card) =>
              PlayingCard(
                card: card,
                visible: true,
              ))
              .toList()),
    );
  }
}
