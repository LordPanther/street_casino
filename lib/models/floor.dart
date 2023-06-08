import '../components/discard_pile.dart';
import '../components/player_model.dart';

class Floor {
  late List<DiscardPile> openSlots;
  late final List<PlayerModel> players;

  Floor({
    this.openSlots = const [],
    required this.players
  });
}