 import '../components/player_model.dart';

class Turn {
  final List<PlayerModel> players;
  int index;
  PlayerModel currentPlayer;

  Turn({
    required this.players,
    required this.currentPlayer,
    this.index = 0,
  });

  void nextTurn() {
    index = (index + 1) % players.length;
    currentPlayer = players[index];
  }


  PlayerModel get otherPlayer {
    return players.firstWhere((p) => p != currentPlayer);
  }
 }