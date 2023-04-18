import 'package:flutter/material.dart';
import 'package:street_casino/constants.dart';
import 'package:street_casino/main.dart';
import 'package:street_casino/models/card_model.dart';
import 'package:street_casino/models/deck_model.dart';
import 'package:street_casino/services/deck_service.dart';

import '../components/player_model.dart';
import '../models/turn_model.dart';

abstract class GameProvider with ChangeNotifier {
  GameProvider() {
    _service = DeckService();
  }

  late DeckService _service;

  late Turn _turn;
  Turn get turn => _turn;

  DeckModel? _currentDeck;
  DeckModel? get currentDeck => _currentDeck;

  List<PlayerModel> _players = [];
  List<PlayerModel> get players => _players;

  List<CardModel> _discards = [];
  List<CardModel> get discards => _discards;
  CardModel? get discardTop => _discards.isEmpty ? null : _discards.last;

  Map<String, dynamic> gameState = {};
  Widget? bottomWidget;

  Future<void> newGame(List<PlayerModel> players) async {
    final deck = await _service.newDeck();
    _currentDeck = deck;
    _players = players;
    _discards = [];
    _turn = Turn(
      players: players,
      currentPlayer: players.first,
    );
    setupBoard();

    notifyListeners();
  }

  Future<void> setupBoard() async {}

  Future<void> drawCardToDiscardPile({int count = 1}) async {
    final draw = await _service.drawCards(_currentDeck!, count: count);

    _currentDeck!.remaining = draw.remaining;
    _discards.addAll(draw.cards);

    notifyListeners();
  }

  void setBottomWidget(Widget? widget) {
    bottomWidget = widget;

    notifyListeners();
  }

  void setTrump(Suit suit) {
    setBottomWidget(
     Card(
       child: Text(
         CardModel.suitToUnicode(suit),
         style: TextStyle(
           fontSize: 24,
           color: CardModel.suitToColor(suit),
         ),
       ),
     )
    );
  }

  void setLastPlayed(CardModel card) {
    gameState[GS_LAST_SUIT] = card.suit;
    gameState[GS_LAST_VALUE] = card.value;

    setTrump(card.suit);

    notifyListeners();
  }

  bool get canDrawCard {
    return turn.drawCount < 1;
  }

  Future<void> drawCards(PlayerModel player, {int count = 1, bool allowAnyTime = false}) async {

    if (currentDeck == null) return;
    if (!allowAnyTime && !canDrawCard) return;

    final draw = await _service.drawCards(_currentDeck!, count: count);

    player.addCards(draw.cards);

    _turn.drawCount += count;

    _currentDeck!.remaining = draw.remaining;

    notifyListeners();
  }

  bool canPlayCard(CardModel card) {
    return _turn.actionCount < 1;
  }

  Future<void> playCard({
    required PlayerModel player,
    required CardModel card,
  }) async {
    if (!canPlayCard(card)) return;

    player.removeCard(card);

    _discards.add(card);

    _turn.actionCount += 1;

    setLastPlayed(card);

    await applyCardSideEffect(card);

    notifyListeners();

  }

  Future<void> applyCardSideEffect(CardModel card) async {}

  bool get canEndTurn {
    return turn.drawCount > 0;
  }

  void endTurn() {
    _turn.nextTurn();

    if(_turn.currentPlayer.isBot) {
      botTurn();
    }

    notifyListeners();
  }

  void skipTurn() {
    _turn.nextTurn();
    _turn.nextTurn();

    notifyListeners();
  }

  Future<void> botTurn() async {
    await Future.delayed(const Duration(microseconds: 500));
    await drawCards(_turn.currentPlayer);
    await Future.delayed(const Duration(microseconds: 500));

    if (_turn.currentPlayer.cards.isNotEmpty) {
      await Future.delayed(const Duration(microseconds: 1000));
      playCard(
          player: _turn.currentPlayer, card: _turn.currentPlayer.cards.first);
    }

    if (canEndTurn) {
      endTurn();
    }
  }

  void showToast(String message, {int seconds = 3,SnackBarAction? action}) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),
        action: action,
      ),
    );
  }
}