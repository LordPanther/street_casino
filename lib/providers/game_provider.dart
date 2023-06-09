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

  bool _hasPlayed = false;
  bool get hasPlayed => _hasPlayed;

  DeckModel? _currentDeck;
  DeckModel? get currentDeck => _currentDeck;

  List<PlayerModel> _players = [];
  List<PlayerModel> get players => _players;

  CardModel? _cardToPlay;
  CardModel? get cardToPlay => _cardToPlay;

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
    setupBoard();
    _turn = Turn(
      players: players,
      currentPlayer: players.first,   //Same as players[0]
    );

    notifyListeners();
  }

  Future<void> setupBoard() async {}

  //Player draws card to an empty slot or own pile

  Future<void> drawCardToDiscardPile({int count = 1}) async {
    final draw = await _service.drawCards(_currentDeck!, count: count);

    _currentDeck!.remaining = draw.remaining;
    _discards.addAll(draw.cards);

    notifyListeners();
  }

  //Bottom widget that shows current suit

  void setBottomWidget(Widget? widget) {
    bottomWidget = widget;

    notifyListeners();
  }

  void setTrump(Suit suit) {
    setBottomWidget(Card(
      child: Text(
        CardModel.suitToUnicode(suit),
        style: TextStyle(
          fontSize: 24,
          color: CardModel.suitToColor(suit),
        ),
      ),
    ));
  }

  void setLastPlayed(CardModel card) {
    gameState[GS_LAST_SUIT] = card.suit;
    gameState[GS_LAST_VALUE] = card.value;

    setTrump(card.suit);

    notifyListeners();
  }

  //When game starts each player is drawn 10 cards from the stack

  Future<void> drawCards(PlayerModel player,
      {int count = 1, bool allowAnyTime = false}) async {
    if (currentDeck == null) return;
    if (!allowAnyTime) return;

    final draw = await _service.drawCards(_currentDeck!, count: count);

    player.addCards(draw.cards);

    _currentDeck!.remaining = draw.remaining;

    notifyListeners();
  }

  bool canPlayCard(CardModel card) {

    if (gameOver) return false;

    return true;

    // return _turn.actionCount < 1;
  }

  //Holding card to be played

  Future<void> holdCard({
    required PlayerModel player,
    required CardModel card
  }) async {
    // print("Holding card in hand: ${card.value}, ${card.suit}");
    _cardToPlay = card;

    notifyListeners();
  }

  //When card is tapped this happens

  Future<void> playCardHuman({
    required PlayerModel player,
    // required CardModel card,
  }) async {

    player.removeCard(_cardToPlay!);

    _discards.add(_cardToPlay!);

    setLastPlayed(_cardToPlay!);

    // await applyCardSideEffect(card);

    if (gameOver) {
      finishGame();
    }

    _hasPlayed = true;

    notifyListeners();
  }

  //Bot card player

  Future<void> playCard({
    required PlayerModel player,
    required CardModel card,
  }) async {
    print("playCard: ${card.suit}");
    // if (!canPlayCard(card)) return;

    player.removeCard(card);

    _discards.add(card);

    setLastPlayed(card);

    // await applyCardSideEffect(card);

    if (gameOver) {
      finishGame();
    }
    notifyListeners();
  }

  Future<void> applyCardSideEffect(CardModel card) async {}

  // bool get canEndTurn {
  //   return turn.drawCount > 0;
  // }

  void endTurn() {
    _turn.nextTurn();

    if (_turn.currentPlayer.isBot) {
      botTurn();
    }

    _hasPlayed = false;

    notifyListeners();
  }

  bool get gameOver {
    return currentDeck!.remaining < 1;
  }

  void finishGame() {
    showToast("Game Over!");

    notifyListeners();
  }

  Future<void> botTurn() async {

    if (_turn.currentPlayer.cards.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      playCard(
          player: _turn.currentPlayer, card: _turn.currentPlayer.cards.first);
    }

    //End bot turn and continue to next player

    endTurn();

  }

  void showToast(String message, {int seconds = 3, SnackBarAction? action}) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),
        action: action,
      ),
    );
  }
}
