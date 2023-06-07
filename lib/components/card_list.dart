import 'package:flutter/cupertino.dart';
import 'package:street_casino/components/player_model.dart';
import 'package:street_casino/components/playing_card.dart';
import 'package:street_casino/constants.dart';
import 'package:street_casino/models/card_model.dart';

class CardList extends StatelessWidget {
  final double size;
  final PlayerModel player;
  final Function(CardModel)? onPlayCard;

  const CardList({
    Key? key,
    required this.player,
    this.size = 1,
    this.onPlayCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return player.isHuman
        ? SizedBox(
            height: CARD_HEIGHT * size,
            width: double.infinity,
            child: Stack(
              children: List.generate(player.cards.length, (index) {
                final card = player.cards[index];
                final cardPosition = index * 30.0;

                return Positioned(
                  left: cardPosition,
                  child: PlayingCard(
                    card: card,
                    size: size,
                    visible: player.isHuman,
                    onPlayCard: onPlayCard,
                  ),
                );
              }).toList(),
            ),
          )
        : SizedBox(
            height: CARD_HEIGHT * size,
            width: double.infinity,
            child: Stack(
              children: List.generate(player.cards.length, (index) {
                final card = player.cards[index];
                final cardPosition = index * 10.0;

                return Positioned(
                  left: cardPosition,
                  child: PlayingCard(
                    card: card,
                    size: size,
                    visible: player.isHuman,
                    onPlayCard: onPlayCard,
                  ),
                );
              }).toList(),
            ));
  }
}
