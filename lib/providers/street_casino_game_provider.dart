import 'package:flutter/material.dart';
import 'package:street_casino/components/suit_chooser_modal.dart';
import 'package:street_casino/constants.dart';
import 'package:street_casino/main.dart';
import 'package:street_casino/models/card_model.dart';
import 'package:street_casino/providers/game_provider.dart';

class StreetCasinoGameProvider extends GameProvider {

  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCards(p, count: 10, allowAnyTime: true);
    }

    await drawCardToDiscardPile();

    setLastPlayed(discardTop!);
  }

  @override
  bool get canEndTurn {
    if (turn.drawCount > 0 || turn.actionCount > 0) {
      return true;
    }

    return false;
  }

  @override
  bool canPlayCard(CardModel card) {
    bool canPlay = false;

    if (gameState[GS_LAST_SUIT] == null || gameState[GS_LAST_VALUE] == null) {
      return false;
    }

    if (gameState[GS_LAST_SUIT] == card.suit) {
      canPlay = true;
    }

    if (gameState[GS_LAST_VALUE] == card.value) {
      canPlay = true;
    }

    if (card.value == "8") {
      canPlay = true;
    }

    return canPlay;
  }

  @override
  Future<void> applyCardSideEffect(CardModel card) async {

    if (card.value == "8") {
      Suit suit;

      if (turn.currentPlayer.isHuman) {
        suit = await showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => const SuitChooserModal(),
          barrierDismissible: false,
        );
      } else {
        suit = turn.currentPlayer.cards.first.suit;
      }

      gameState[GS_LAST_SUIT] = suit;
      setTrump(suit);
      showToast("${turn.currentPlayer} has changed it to ${CardModel.suitToString(suit)}");

    } else if (card.value == "2") {
      await drawCards(turn.otherPlayer, count: 2, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} has to draw 2 cards!");
    } else if (card.value == "QUEEN" && card.suit == Suit.Spades) {
      await drawCards(turn.otherPlayer, count: 5, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} has to draw 5 cards!");
    } else if (card.value == "JACK") {
      showToast("${turn.otherPlayer.name} has to draw 2 cards!");
      skipTurn();
    }

    notifyListeners();
  }

  @override
  Future<void> botTurn() async {
    final p = turn.currentPlayer;

    await Future.delayed(const Duration(microseconds: 1000));

    for (final c in p.cards) {
      if (canPlayCard(c)) {
        await playCard(player: p, card: c);
        endTurn();
        return;
      }
    }

    await Future.delayed(const Duration(microseconds: 1000));
    await drawCards(p);
    await Future.delayed(const Duration(microseconds: 1000));

    if (canPlayCard(p.cards.last)) {
      await playCard(player: p, card: p.cards.last);
    }

    endTurn();
  }
}