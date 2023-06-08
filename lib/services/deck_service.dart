import 'package:street_casino/models/deck_model.dart';
import 'package:street_casino/models/draw_model.dart';
import 'package:street_casino/services/api_service.dart';

class DeckService extends ApiService {
  // Game starts with 40 cards

  String cards =
      'AS,AD,AC,AH,2C,2S,2D,2H,3C,3S,3D,3H,4C,4S,4D,4H,5C,5S,5D,5H,6C,6S,6D,6H,7C,7S,7D,7H,8C,8S,8D,8H,9C,9S,9D,9H,0C,0S,0D,0H';

  Future<DeckModel> newDeck([int deckCount = 1]) async {
    final data = await httpGet(
      '/deck/new/shuffle',
      params: {'cards': cards, 'deck_count': deckCount},
    );

    return DeckModel.fromJson(data);
  }

  Future<DrawModel> drawCards(DeckModel deck, {int count = 1}) async {
    final data = await httpGet(
      '/deck/${deck.deck_id}/draw',
      params: {'count': count},
    );

    return DrawModel.fromJson(data);
  }
}
